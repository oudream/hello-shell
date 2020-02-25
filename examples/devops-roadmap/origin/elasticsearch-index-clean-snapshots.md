# ElasticSearch索引的快照、清理策略

# 一、简介

当使用ES存储接入的应用日志时，日志索引会日益增多。而真实的日志查询需求一般是要求半月可查，存储半年到一年。应用每天产生的日志普遍会存到对应ES中以当天日期命名的索引中。查询时根据需求，最多查询半月对应索引里的数据。至于超过半月以上的日志索引数据，可快照文件，存储到文件系统中。在有特殊场景需求时进行快照恢复进行查询。这样减小ES的索引压力，提高查询效率。

## 需求

- 将半月以上的日志索引快照成文件，存储到快照仓库中
- 删除已快照的日志索引
- 定时检测创建超过15天的索引并快照、清理
- 钉钉通知快照后删除的索引名称
- 脚本执行错误时告警

# 二、快照清理脚本

```bash
#!/bin/bash
export SENTRY_DSN=http://*****@sentry.okd.curiouser.com/28
eval "$(sentry-cli bash-hook)"

elasticsearch_host=${ELASTICSEARCH_HOST:192.168.1.2}
elasticsearch_username=${ELASTICSEARCH_USERNAME:cronjob}
elasticsearch_password=${ELASTICSEARCH_PASSWORD:******}
elasticsearch_index_expiry_day=${ELASTICSEARCH_INDEX_EXPIRY_DAY:15}
elasticsearch_exclude_index=${ELASTICSEARCH_EXCLUDE_INDEX:.*}
elasticsearch_snapshots_repository=${ELASTICSEARCH_SNAPSHOTS_REPOSITORY:***}

elasticsearch_index_expiry_sec=$((elasticsearch_index_expiry_day*86400))
elasticsearch_url="http://${elasticsearch_host}:9200"
allIndex=`curl -s -u ${elasticsearch_username}:${elasticsearch_password} -XGET "${elasticsearch_url}/_cat/indices/_all?h=index"`
excludeIndex=`curl -s -u ${elasticsearch_username}:${elasticsearch_password} -XGET "${elasticsearch_url}/_cat/indices/${elasticsearch_exclude_index}/?h=i"`
indices=`echo -e "$allIndex\n""$excludeIndex" |sort -n |uniq -u`

for i in $indices ;
do
  createdateincludemesc=`curl -s -u ${elasticsearch_username}:${elasticsearch_password} -XGET "${elasticsearch_url}/_cat/indices/$i?h=cd"` ;
  createdate=$((createdateincludemesc/1000))
  currentdate=`date +%s`
  durationtime=$((currentdate-createdate)) ;
  if [ $durationtime -gt $elasticsearch_index_expiry_sec ] ;then
     snapshotsIndices=$i"\n"${snapshotsIndices}
  fi
done

for i in `echo -e $snapshotsIndices` ;
do
  if [ `curl -o /dev/null -w "%{http_code}\n" -s -u ${elasticsearch_username}:${elasticsearch_password} -XPUT "${elasticsearch_url}/_snapshot/${elasticsearch_snapshots_repository}/%3C$i-%7Bnow%2Fd%7D%3E?wait_for_completion=true" -H 'Content-Type: application/json' -d'{"indices": "'$i'","ignore_unavailable": true,"include_global_state": false}'` = 200 ] ;then
    if [ `curl -o /dev/null -w "%{http_code}\n" -s -u ${elasticsearch_username}:${elasticsearch_password} -XDELETE "${elasticsearch_url}/$i"` = 200 ] ;then
      echo -e "The Index $i \t have been snapshoted to repository and deleted !" ;
    else
      echo "$i failed to delete " ;
    fi
  else
    echo "$i failed to snapshot " ;
  fi
done

curl -s -o /dev/null 'https://oapi.dingtalk.com/robot/send?access_token=*****' \
  -H 'Content-Type: application/json' \
  -d '{"msgtype": "text",
       "text": {"content": "已成功将以下'"$elasticsearch_index_expiry_day"'天之前的索引进行了快照：\n'"$snapshotsIndices"'"}
  }'
```

## 脚本功能

- 通过环境变量设置参数
- 脚本执行完成后发送钉钉通知，显示脚本涉及到的ES索引
- 集成Sentry告警，每当脚本执行出错时将时间发送至Sentry，再由Sentry进行邮件告警
- 可使用Linux cron工具或K8S上的cornjob定时每天早上1点执行该脚本

# 三、脚本部署执行

## Linux的Cronjob

```bash
echo "0 1 * * * /opt/es-index-snapshots.sh" > /etc/crontab
```

## Kubernetes的cronjob

### 1、构建Cronjob镜像

Dockerfile

```bash
FROM centos:7
RUN curl -sL https://sentry.io/get-cli/ | bash
ADD ./es-index-snapshots.sh /usr/sbin/es-index-snapshots.sh
Entrypoint ["/bin/sh","-c"]
CMD ["/usr/sbin/es-index-snapshots.sh"]
```

```bash
docker build -t es-index-snapshots:v1 .
```

### 2、k8s资源声明文件

es-index-snapshots-cronjob.yml

```bash
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: es-index-snapshots-cronjob
  namespace: logging
spec:
  concurrencyPolicy: Allow
  failedJobsHistoryLimit: 1
  schedule: 0 1 * * *
  startingDeadlineSeconds: 200
  successfulJobsHistoryLimit: 3
  suspend: false
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - env:
            - name: TZ
              value: Asia/Shanghai
            - name: ELASTICSEARCH_HOST
              value: *.logging.svc
            - name: ELASTICSEARCH_USERNAME
              value: cronjob
            - name: ELASTICSEARCH_PASSWORD
              value: "***""
            - name: ELASTICSEARCH_INDEX_EXPIRY_DAY
              value: "15"
            - name: ELASTICSEARCH_EXCLUDE_INDEX
              value: .*
            - name: ELASTICSEARCH_SNAPSHOTS_REPOSITORY
              value: "***"
            image: es-index-snapshots:v1
            imagePullPolicy: Always
            name: es-index-snapshots-cronjob
            resources:
              limits:
                cpu: 600m
                memory: 800Mi
              requests:
                cpu: 300m
                memory: 500Mi
            terminationMessagePath: /dev/termination-log
            terminationMessagePolicy: File
          dnsPolicy: ClusterFirst
          imagePullSecrets:
          - name: harbor-secrets
          restartPolicy: OnFailure
          schedulerName: default-scheduler
          securityContext: {}
          terminationGracePeriodSeconds: 30

```

```bash
kubectl apply -f es-index-snapshots-cronjob.yml
```

