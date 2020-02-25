## Gitlab代码仓库的备份与恢复

# 一、Preface

GItlab上的代码仓库需要进行定期的导出备份，并且可以随时进行恢复

# 二、通过API导出代码仓库

| 支持导出的数据项                                             | 不支持导出的数据项         |
| ------------------------------------------------------------ | -------------------------- |
| Project and wiki repositories                                | Build traces and artifacts |
| Project uploads                                              | Container registry images  |
| Project configuration, including services                    | CI variables               |
| Issues with comments, merge requests with diffs <br>and comments, labels, milestones, snippets, <br/>and other project entities | Webhooks                   |
| Design Management files and data                             | Any encrypted tokens       |
| LFS objects                                                  | Merge Request Approvers    |
| Issue boards                                                 | Push Rules                 |
|                                                              | Awards                     |

## 通过API接口

### 1. 调用生成Export的接口

**接口及参数**

```
POST /projects/:id/export
```

| Attribute             | Type           | Required | Description                                                  |
| :-------------------- | :------------- | :------- | :----------------------------------------------------------- |
| `id`                  | integer/string | yes      | The ID or [URL-encoded path of the project](https://docs.gitlab.com/ee/api/README.html#namespaced-path-encoding) owned by the authenticated user |
| `description`         | string         | no       | Overrides the project description                            |
| `upload`              | hash           | no       | Hash that contains the information to upload the exported project to a web server |
| `upload[url]`         | string         | yes      | The URL to upload the project                                |
| `upload[http_method]` | string         | no       | The HTTP method to upload the exported project. Only `PUT` and `POST` methods allowed. Default is `PUT` |



```bash
curl --request POST --header "PRIVATE-TOKEN: <your_access_token>" https://gitlab.example.com/api/v4/projects/1/export 
```



### 2. 调用获取Export生成状态的接口

**接口及参数**

| Attribute | Type           | Required | Description                                                  |
| :-------- | :------------- | :------- | :----------------------------------------------------------- |
| `id`      | integer/string | yes      | The ID or [URL-encoded path of the project](https://docs.gitlab.com/ee/api/README.html#namespaced-path-encoding) owned by the authenticated user |

```bash
curl --header "PRIVATE-TOKEN: <your_access_token>" https://gitlab.example.com/api/v4/projects/1/export
```



### 3. 下载Export 

**接口及参数**

```bash
GET /projects/:id/export/download
```

| Attribute | Type           | Required | Description                                                  |
| :-------- | :------------- | :------- | :----------------------------------------------------------- |
| `id`      | integer/string | yes      | The ID or [URL-encoded path of the project](https://docs.gitlab.com/ee/api/README.html#namespaced-path-encoding) owned by the authenticated user |

```bash
curl --header "PRIVATE-TOKEN: <your_access_token>" --remote-header-name --remote-name https://gitlab.example.com/api/v4/projects/5/export/download
```

### 4. 执行脚本

```bash
#/bin/bash

gitlab_url=http://gitlab.apps.okd311.curiouser.com/
gitlab_access_token=*****
gitlab_api_version="api/v4"

for project_id in $(curl -s -XGET ''"$gitlab_url"''"$gitlab_api_version"'/projects?simple=true&order_by=id&sort=asc' -H 'private-token: '"$gitlab_access_token"'' | jq '.[].id')
do
  curl -s -XPOST ''"$gitlab_url"''"$gitlab_api_version"'/projects/'"$project_id"'/export' -H 'private-token: '"$gitlab_access_token"'' > /dev/null
  if [[ `curl -s -XGET ''"$gitlab_url"''"$gitlab_api_version"'/projects/'"$project_id"'/export' -H 'private-token: '"$gitlab_access_token"'' | jq '.export_status' ` =~ "finished" ]];then 
        curl -s -O -XGET ''"$gitlab_url"'/'"$gitlab_api_version"'/projects/'"$project_id"'/export/download' -H 'private-token: '"$gitlab_access_token"''  ;
        echo hahah ; 
  else 
        echo test; 
  fi
done
```



## 通过UI界面

### 1. 仓库页面-->Settings-->General-->Advanced-->Export project按钮

### 2. 点击Export

![](../assets/gitlab-backuprestore-1.png)

### 3. 当Export生成后会发送带有Export下载链接的邮件给代码仓库的维护者

![image-20200106113640611](../assets/gitlab-backuprestore-2.png)

### 4. (可选)后续还可以在UI界面上点击下载Export

![](../assets/gitlab-backuprestore-3.png)

# 三、通过git clone代码到处代码仓库

## shell脚本

```bash
#!/bin/bash
# A script to backup GitLab repositories.

GLAB_BACKUP_DIR=${GLAB_BACKUP_DIR-"gitlab_backup"}                   # where to place the backup files
GLAB_TOKEN=${GLAB_TOKEN-"YOUR_TOKEN"}                                # the access token of the account
GLAB_GITHOST=${GLAB_GITHOST-"gitlab.com"}                            # the GitLab hostname
GLAB_PRUNE_OLD=${GLAB_PRUNE_OLD-true}                                # when `true`, old backups will be deleted
GLAB_PRUNE_AFTER_N_DAYS=${GLAB_PRUNE_AFTER_N_DAYS-7}                 # the min age (in days) of backup files to delete
GLAB_SILENT=${GLAB_SILENT-false}                                     # when `true`, only show error messages
GLAB_API=${GLAB_API-"https://gitlab.com/api/v3"}                     # base URI for the GitLab API
GLAB_GIT_CLONE_CMD="git clone --quiet --mirror git@${GLAB_GITHOST}:" # base command to use to clone GitLab repos

TSTAMP=`date "+%Y%m%d"`

# The function `check` will exit the script if the given command fails.
function check {
  "$@"
  status=$?
  if [ $status -ne 0 ]; then
    echo "ERROR: Encountered error (${status}) while running the following:" >&2
    echo "           $@"  >&2
    echo "       (at line ${BASH_LINENO[0]} of file $0.)"  >&2
    echo "       Aborting." >&2
    exit $status
  fi
}

# The function `tgz` will create a gzipped tar archive of the specified file ($1) and then remove the original
function tgz {
   check tar zcf $1.tar.gz $1 && check rm -rf $1
}

$GLAB_SILENT || (echo "" && echo "=== INITIALIZING ===" && echo "")

$GLAB_SILENT || echo "Using backup directory $GLAB_BACKUP_DIR"
check mkdir -p $GLAB_BACKUP_DIR

$GLAB_SILENT || echo -n "Fetching list of repositories ..."
GLAB_PROJ_API="${GLAB_API}/projects?private_token=${GLAB_TOKEN}&per_page=100&simple=true"
echo ${GLAB_PROJ_API}

REPOLIST=`check curl --silent ${GLAB_PROJ_API} | check perl -p -e "s/,/\n/g" | check grep "\"path_with_namespace\"" | check awk -F':"' '{print $2}' | check sed -e 's/"}//g'`

$GLAB_SILENT || echo "found `echo $REPOLIST | wc -w` repositories."

$GLAB_SILENT || (echo "" && echo "=== BACKING UP ===" && echo "")

for REPO in $REPOLIST; do
   $GLAB_SILENT || echo "Backing up ${REPO}"
   check ${GLAB_GIT_CLONE_CMD}${REPO}.git ${GLAB_BACKUP_DIR}/${GLAB_ORG}-${REPO}-${TSTAMP}.git && tgz ${GLAB_BACKUP_DIR}/${GLAB_ORG}-${REPO}-${TSTAMP}.git
done

if $GLAB_PRUNE_OLD; then
  $GLAB_SILENT || (echo "" && echo "=== PRUNING ===" && echo "")
  $GLAB_SILENT || echo "Pruning backup files ${GLAB_PRUNE_AFTER_N_DAYS} days old or older."
  $GLAB_SILENT || echo "Found `find $GLAB_BACKUP_DIR -name '*.tar.gz' -mtime +$GLAB_PRUNE_AFTER_N_DAYS | wc -l` files to prune."
  find $GLAB_BACKUP_DIR -name '*.tar.gz' -mtime +$GLAB_PRUNE_AFTER_N_DAYS -exec rm -fv {} > /dev/null \;
fi

$GLAB_SILENT || (echo "" && echo "=== DONE ===" && echo "")
$GLAB_SILENT || (echo "GitLab backup completed." && echo "")
```



# 参考

1. # https://docs.gitlab.com/ee/api/project_import_export.html
2. https://docs.gitlab.com/ee/user/project/settings/import_export.html
3. https://gist.github.com/devopstaku/7b1b2594ce657957206f3ec5f262eadb