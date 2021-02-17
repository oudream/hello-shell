dirname=`date +%Y%m%d`
cdn_endpoint=https://ftofs-editor.oss-cn-shenzhen.aliyuncs.com

#overwrite config
project_list=(admin api seller web worker)
for project in ${project_list[@]}
do
    echo -e "publicRoot=${cdn_endpoint}/public/${dirname}\n" >> /opt/a-${project}.txt
    echo -e "jsRoot=${cdn_endpoint}/${project}/${dirname}/static/js/\n" >> /opt/a-${project}.txt
    echo -e "cssRoot=${cdn_endpoint}/${project}/${dirname}/static/css/\n" >> /opt/a-${project}.txt
    echo -e "imgRoot=${cdn_endpoint}/${project}/${dirname}/static/img/\n" >> /opt/a-${project}.txt
    echo -e "toolkitRoot=${cdn_endpoint}/${project}/${dirname}/static/toolkit/\n" >> /opt/a-${project}.txt
done
