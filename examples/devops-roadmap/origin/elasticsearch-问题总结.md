# 一、elasticsearch集群开启“xpack的monitoring功能“导致”failed to flush export bulks和 there are no ingest nodes in this cluster”报错

**原因**：

xpack的monitoring功能需要定义exporter用于导出监控数据， 默认的exporter是local exporter，也就是直接写入本地的集群，并且要求节点开启了ingest选项。

**解决方案**:

1. 将集群的结点配置里的ingest角色打开
2. 或者在集群设置elasticsearch.yml里，将local exporter的use ingest关掉
   ```yaml
    xpack.monitoring.exporters.my_local:
    type: local
    use_ingest: false
   ```
但一般的，使用local cluster监控自己存在很大的问题，故障发生时，监控也没法看到了。 生产上最好是设置一个单独的监控集群，然后可以配置一个HTTP exporter，将监控数据送往这个监控集群

**参考**：

1. https://www.elastic.co/guide/en/x-pack/5.5/monitoring-cluster.html#http-exporter-reference
2. https://elasticsearch.cn/question/1915



# 二、Elasticsearch的监控日志索引Index的保存期限为7天

Elasticsearch的监控日志索引Index为"`.monitoring-*`"开头的，保存期限为7天，7天之后会自动删除。

**参考**

1. https://discuss.elastic.co/t/how-system-index-like-monitoring-es-6-2018-02-06-are-being-deleted-automatically/119578