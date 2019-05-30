#!/usr/bin/env bash

cat <<EOF
                      __
  ___  ____ _      __/ /__
 / _ \/ __ \ | /| / / //_/
/  __/ /_/ / |/ |/ / ,<
\___/ .___/|__/|__/_/|_|
   /_/
EOF

basepath=$(cd `dirname $0`; pwd)
configFile=${basepath}/config.yaml

if [ -f ${configFile} ]; then
    echo "配置文件已经存在，如有变更请编辑[${configFile}]后重启vagrant"
    echo "正在启动 Vagrant..."
    cd ${basepath}
    vagrant up
else
    read -p "请输入[git config --global user.name]:" git_user
    read -p "请输入[git config --global user.email]:" git_email
    read -p "请输入挂载的路径，直接回车使用当前项目下的[data/webroot]:" webroot
    if [ ! -n ${webroot} ]; then
        webroot=data/webroot
    fi

    echo "正在生成配置文件[${configFile}]..."
    cp ${configFile}.example ${configFile}
    echo "system: linux">>${configFile}
    echo "git_user: ${git_user}">>${configFile}
    echo "git_email: ${git_email}">>${configFile}
    echo "webroot: ${webroot}">>${configFile}

    echo "正在启动 Vagrant..."
    cd ${basepath}
    vagrant up
fi
