#!/usr/bin/env bash

THIS_MONTH=`date +'%Y%m'` #年月
THIS_DAY_TIME=`date +'%Y%m%d%H%M%S'` #年月日时分秒
THIS_DAY=`date +%Y%m%d` #今天
THIS_TIME=`date +'%H%M%S'` #当前时间

THIS_DAY_SP=`date +%Y-%m-%d` #今天，分隔符
THIS_TIME_SP=`date +'%H:%M:%S'` #当前时间,分隔符

THIS_RANDOM=$RANDOM;#本次任务的随机数,随机数处理多人同时，或操作间隔过快

NAME_PROJECT='dialog_system'

DIR_PROJECT_ROOT=$(pwd)

DIR_PROJECT_BUILD=${DIR_PROJECT_ROOT}/build

DIR_PROJECT_TEST=${DIR_PROJECT_ROOT}/test

DIR_PROJECT_LOG=${DIR_PROJECT_ROOT}/../dialog_system_log/build_start

FILE_LOG_BUILD=${DIR_PROJECT_LOG}/${THIS_DAY}'.'${THIS_TIME}'.build.log.txt'
FILE_LOG_MAIN_SERVER=${DIR_PROJECT_LOG}/${THIS_DAY}'.'${THIS_TIME}'.main_server.log.txt'
FILE_LOG_WEB_PY=${DIR_PROJECT_LOG}/${THIS_DAY}'.'${THIS_TIME}'.web_py.log.txt'

TAG_BUILD_SUCC='BUILD ALL MODULES SUCC.'
TAG_MAIN_SERVER_SUCC='server start succ ...'

SPEC_PORT_ARR=(9876 8080)


function check_pre_build()
{
	if [ ! -d ${DIR_PROJECT_ROOT} ];then
		echo "${DIR_PROJECT_ROOT} not valid catalog"
	    exit 10
	fi

	if [ -d ${DIR_PROJECT_BUILD} ];then
		cd ${DIR_PROJECT_BUILD}
		rm -rf ./*
	fi

	if [ ! -d ${DIR_PROJECT_LOG} ];then
		echo 'create DIR_PROJECT_LOG'
	    mkdir -p ${DIR_PROJECT_LOG}
	fi
}

function kill_spec_port_pro(){
	process_id_arr=()
	process_id_arr_uniq=()
	key_num=0
	for port in ${SPEC_PORT_ARR[@]};do
		echo "port:"${port}

		if [ ${port} != '' ];then
			process_id=`netstat -nlp | grep :$port | awk '{print $7}' | awk -F"/" '{ print $1 }'`
			echo "process_id:"${process_id}
			if [[ $(echo $process_id | grep " ") != "" ]];then
                process_id=`echo $process_id | awk -F ' ' '{print $1}'`
                echo "分割，去重，获取第一个，process_id:"${process_id}
            fi
			if [ "${process_id}" != ""  ];then

				key_num=`expr $key_num + 1`
				process_id_arr[$key_num]=${process_id}
			fi
		fi
	done

	echo ${#process_id_arr[@]}



	for proc_id in ${process_id_arr[@]};do
		echo "proc_id:"$proc_id
		#proc_id=`remove_space ${proc_id}`
		if [ "${proc_id}" != '' ];then
			echo "kill proc_id:"${proc_id}
			kill -9 ${proc_id}
		fi
	done

}

function build_project()
{
	cd ${DIR_PROJECT_ROOT}
	echo "about to begin build project,please run:tail -f ${FILE_LOG_BUILD}"
	sh ./build.sh >> ${FILE_LOG_BUILD} 2>&1
	run_res=`tail -2 ${FILE_LOG_BUILD}|head -1`
	tag_is_succ=$(echo ${run_res} | grep "${TAG_BUILD_SUCC}")
	if [  ${#tag_is_succ}  = 0  ];then
		echo "${DIR_PROJECT_ROOT} build fail.please see ${FILE_LOG_BUILD}"
		exit 20
	fi
}

function run_project()
{
    cd ${DIR_PROJECT_ROOT}
    cp -rf build/rpc_service/main_server test/bin/
    cp -rf rpc_service/scripts/* test/scripts/

	cd ${DIR_PROJECT_TEST}
	echo "about to begin main server,please run:tail -f ${FILE_LOG_MAIN_SERVER}"
	nohup ./bin/main_server >> ${FILE_LOG_MAIN_SERVER} 2>&1 &
	run_res=`tail -2 ${FILE_LOG_MAIN_SERVER}`

	echo "about to begin web py,please run:tail -f ${FILE_LOG_WEB_PY}"
	nohup python -u ./scripts/web.py >> ${FILE_LOG_WEB_PY} 2>&1 &
}

function remove_space()
{
	return `echo $1 | sed 's/[[:space:]]'//g`
}

function build_run_project()
{
	echo '开始编译时间：'`date +'%Y%m%d %H%M%S %N'`

	check_pre_build
	if [[ "$?" != "0" ]];then
		echo 'check_pre_build fail,please check'
		exit 40
	fi

	build_project
	if [[ "$?" != "0" ]];then
		echo 'build_project fail,please check'
		exit 50
	fi

	kill_spec_port_pro
	if [[ "$?" != "0" ]];then
		echo 'kill_spec_port_pro fail,please check'
		exit 60
	fi

	echo '结束编译时间：'`date +'%Y%m%d %H%M%S %N'`
	run_project
	if [[ "$?" != "0" ]];then
		echo 'run_project fail,please check'
		exit 70
	fi

	echo '结束运行时间：'`date +'%Y%m%d %H%M%S %N'`
	echo 'build run complete,please check,such as:'
	echo '命令行,curl -G --data-urlencode "content=大决战" 127.0.0.1:8080/text_classify'
	echo '浏览器地址栏,127.0.0.1:8080/text_classify?content=大决战'
}

build_run_project
