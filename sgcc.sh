#!/bin/bash

# ./sgcc [옵션] [매개변수]
# 옵션:
##### init (-I)           필요한 디렉토리를 초기화합니다.
##### run  (-R) [Args]    빌드 후, 컴파일된 바이러니를 [Args]와 함께 실행합니다.

#-----------------------------------경로 설정-----------------------------------
MAIN_PATH="src"           # 진입점(main.c)이 포함된 경로입니다.
OUTPUT_PATH="output"      # 컴파일된 바이러니가 저장될 경로입니다.
OUTPUT_NAME="main"        # 컴파일된 바이러니 파일의 이름입니다.

#-----------------------------------출력 관련-----------------------------------
P_BUILD_STATE=1           # 빌드 성공/실패 여부를 출력합니다. (0 | 1)

#-----------------------------------메세지 설정-----------------------------------
BUILD_SUCCESS="빌드 성공"
BUILD_FAILURE="빌드 실패"
ERROR_NEED_ARGS="매개변수가 전달되지 않았습니다."
ERROR_UNKNOWN_ARGS="알 수 없는 옵션입니다"

#-----------------------------------기타 설정-----------------------------------
OPTION_INIT="init"
OPTION_INIT_S="-I"
OPTION_RUN="run"
OPTION_RUN_S="-R"

args=$@

function init {
    if ! [[ -d $OUTPUT_PATH ]]; then
        mkdir $OUTPUT_PATH;
    fi
}

function d () {
    if [ $P_BUILD_STATE -eq 1 ]; then
        w=$((($COLUMNS - ${#1} * 4) / 2))
        eval printf '=%.0s' {1..$[$w]}
        for i in "$*"; do printf "$i"; done;
        eval printf '=%.0s' {1..$[$w]}
        printf "\n"
    fi
}

function run {
    init
    if [ -x "$(command -v gcc)" ]; then
        gcc -fdiagnostics-color=always -g "./${MAIN_PATH}/main.c" -o "./${OUTPUT_PATH}/${OUTPUT_NAME}"
        case $? in
            0)
                d $BUILD_SUCCESS
                args=${args:3}
                ./${OUTPUT_PATH}/${OUTPUT_NAME} ${args}
            ;;
            *) d $BUILD_FAILURE
            ;;
        esac
    fi
}

if [ $# -eq 0 ]; then
    echo $ERROR_NEED_ARGS
else
    case $1 in
        $OPTION_RUN | $OPTION_RUN_S) run ;;
        $OPTION_INIT | $OPTION_INIT_S ) init ;;
        *) echo "$ERROR_UNKNOWN_ARGS: ${1}" ;;
    esac
fi