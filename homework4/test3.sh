#!/usr/bin/env bash

function help{
    echo "doc"
    echo "-o     统计访问来源主机TOP 100和分别对应出现的总次数"
    echo "-i     统计访问来源主机TOP 100 IP和分别对应出现的总次数"
    echo "-u     统计最平凡被访问的URL TOP 100"
    echo "-c     统计不同响应状态码出现次数和对应百分比"
    echo "-f     分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数"
    echo "-s URL 给定URL输出TOP 100访问来源主机"
    echo "-h     帮助文档"
}

# 统计访问来源主机TOP100 和分别对应出现的总次数
function top100_ost{
    printf "%40s\t%s\n" "TOP100_host" "count"
    awk -F "\t" '
    NR>1 {host[$1]++;}
    END { for(i in host) {printf("%40s\t%d\n",i,host[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -100

}

# 统计访问来源主机TOP 100 IP和分别对应出现的总次数
function top100_p {
    printf "%20s\t%s\n" "TOP100_IP" "count"
    awk -F "\t" '
    NR>1 {if(match($1, /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/)) ip[$1]++;}
    END { for(i in ip) {printf("%20s\t%d\n",i,ip[i]);} }
    ' web_log.tsv |sort -g -k 2 -r |head -100

}

#统计最频繁被访问的URLTOP 100
