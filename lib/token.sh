#!/bin/bash
read_config(){
    #read config.json
    #read_config <key>
    value=$(cat $PWD/config.json | jq . ${1} -r);
    if [ $value == "" ]
    then
	echo "[ERR] Error reading configuration" >&2;
	exit 1;
    fi
    echo $value;
    exit 0;
}
get_baidu_access_token(){
    appid=$(read_config appid);
    seckey=$(read_config secretkey);
    access_token=$(curl -s "https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=${appid}&client_secret=${seckey}" | jq .access_token -r);
    if [ $access_token == ""]
    then
	echo "[ERR] Error reading configuration" >&2;
        exit 1;
    fi
}

    
    
	    
