#!/bin/bash

# 使い方: run-client-container <runner_os>(github actionsから呼び出す場合にのみ)

function get_runner_os(){
  echo "$1"
}

function is_windows(){
  runner_os=$(get_runner_os "$@") 
  [[ "$runner_os" = "Windows" || "$OSTYPE" = "msys" ]];
  return $?
}

function is_macos(){
  runner_os=$(get_runner_os "$@")
  [[ "$runner_os" = "macOS" || "$OSTYPE" =~ "darwin" ]];
  return $?
}

function call_from_github_action(){
  [[ ! "$GITHUB_WORKSPACE" = "" || ! "$GITHUB_ENV" = "" ]]
  return $?
}

function get_app_platform(){
  is_windows
  is_windows=$?
  is_macos
  is_macos=$?
  if [ $is_windows = 0 ]; then
    echo "Android"
  elif [ $is_macos = 0 ]; then
    echo "iOS"
  else
    echo "[Error] this is not support os"
    exit 1
  fi
}

function get_github_env_path(){
  call_from_github_action
  declare -r call_from_github_action=$?
  if [ $call_from_github_action = 0 ]; then

    is_windows "$@"
    declare -r is_windows=$?

    is_macos "$@"
    declare -r is_macos=$?

    if [ $is_windows = 0 ]; then
      cygpath "$GITHUB_ENV"
    elif [ $is_macos = 0 ]; then
      echo "$GITHUB_ENV"
    else
      echo "[Error] this is not support os"
      exit 1
    fi
    echo ""
  fi
}


function get_client_repository_root_path(){
  call_from_github_action
  declare -r call_from_github_action=$?
  if [ $call_from_github_action = 0 ]; then
    is_windows "$@"
    declare -r is_windows=$?

    is_macos "$@"
    declare -r is_macos=$?
    if [ $is_windows = 0 ]; then
      cygpath "$GITHUB_WORKSPACE"
    elif [ $is_macos = 0 ]; then
      echo "$GITHUB_WORKSPACE"
    else
      echo "[Error] this is not support os"
      exit 1
    fi
  else
    pwd
  fi
}

client_repository_root_path=$(get_client_repository_root_path "$@")
export REPOSITORY_ROOT_PATH=$client_repository_root_path

github_env_path=$(get_github_env_path "$@")
export GITHUB_ENV=$github_env_path

app_platform=$(get_app_platform "$@")
export PLATFORM=$app_platform

export TO_HOST_BUILD_ROOT_PATH=~/Documents/archives
mkdir -p $TO_HOST_BUILD_ROOT_PATH
echo y | docker container prune
docker-compose build
docker-compose up -d --force-recreate