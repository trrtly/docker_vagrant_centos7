#!/usr/bin/env bash

# 这个文件的命令默认以 sudo 执行，注意权限问题

# 设置DNS
bash -c "cat > /etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 10.0.0.11
nameserver 10.0.0.12
EOF"

# 设置docker仓库
mkdir -p /etc/docker
bash -c 'cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://registry.docker-cn.com"
  ],
  "insecure-registries": [
    "10.0.100.114"
  ]
}
EOF'

# 开机启动docker
systemctl daemon-reload
systemctl restart docker
