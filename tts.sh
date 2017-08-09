#!/bin/bash
#File Name:tts.sh
#OS:Debian
#Time:2017/7/26
#Authors:NullNaN
#E-mail:nullnan0x0000@gmail.com
#API Docs:http://yuyin.baidu.com/docs/tts/136
function install_depend(){
#Install software
sudo apt install curl -y ;
sudo apt install jq -y;
sudo apt install mpg123 -y;
}
#function get_Token{
appid="frFk5iCF0ThMxDwVonGvZ7eN"; #type you AppID
seckey="cf914c2cad80bf53090f1bae688314ba" #type you Secret Key
#}
function get_Access_Token(){
	#return Access Token
	authurl=https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials\&client_id=$appid\&client_secret=$seckey\&
	access_Token=`curl --silent $authurl | jq .access_token -r`
}	
function Generate_url(){
	voiceurl=http://tsn.baidu.com/text2audio?tex=$text\&lan=zh\&cuid=$cuid\&ctp=1\&tok=$access_Token
#tex=$text\&lan=zh\&ctp=1\cuid=$cuid\&tok=$access_Token
}
function get_Text(){
	echo "请输入要合成的内容\033[0;31;40m\u(最大330个字)\033[0m:"
	read text #get input
	
}
function get_mac(){
	#get mac addrest
	#如果你不想让百度获取你的mac值，请注释这个函数
	mac=`sudo ifconfig eth0|grep eth0|awk '{print $5}'`
	cuid=`md5sum $mac`

}
#function get_rand{
	#使用随机数来替代mac作为cuid内容
#	rand=`cat /dev/urandom | tr -cd '[:graph:]' | head -c 12`
#	cuid=$rand
#}
function play_voice(){
	mpg123 $voiceurl 2>/dev/null 1>/dev/null 
}
#install_depend; #在第一次运行时请取消注释，完成依赖安装工作
#get_Token;
get_Access_Token; 
get_mac;  #注重隐私请注释
#get_rand; #并启用这个
get_Text;
Generate_url;
play_voice;
echo "Finish!!"
echo "===================================="

echo $voiceurl #debug
