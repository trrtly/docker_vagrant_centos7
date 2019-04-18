#!/usr/bin/env bash
# change time zone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai
rm -f /etc/yum.repos.d/CentOS-Base.repo
curl http://mirrors.163.com/.help/CentOS7-Base-163.repo -o /etc/yum.repos.d/CentOS-Base.repo
# using socat to port forward in helm tiller
# install  kmod and ceph-common for rook
yum install -y git wget curl conntrack-tools net-tools telnet tcpdump bind-utils socat ntp yum-utils device-mapper-persistent-data lvm2

# enable ntp to sync time
echo 'sync time'
systemctl start ntpd
systemctl enable ntpd
echo 'disable selinux'
setenforce 0
sed -i 's/=enforcing/=disabled/g' /etc/selinux/config

echo 'enable iptable kernel parameter'
cat >> /etc/sysctl.conf <<EOF
net.ipv4.ip_forward=1
EOF
sysctl -p

echo 'set nameserver'
echo "nameserver 8.8.8.8">/etc/resolv.conf
cat /etc/resolv.conf

echo 'disable swap'
swapoff -a
sed -i '/swap/s/^/#/' /etc/fstab

#create group if not exists
egrep "^docker" /etc/group >& /dev/null
if [ $? -ne 0 ]
then
  groupadd docker
fi

usermod -aG docker vagrant
rm -rf ~/.docker/

echo 'install docker'
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum makecache fast
yum install -y docker-ce

mkdir -p /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://registry.docker-cn.com"
  ],
  "insecure-registries": [
    "docker.epwk.tech","10.0.100.114"
  ]
}
EOF

echo 'enable docker'
systemctl daemon-reload
systemctl enable docker
systemctl start docker

echo "cd /data" >> /home/vagrant/.bashrc

echo 'install docker-compose'
sudo curl -Ls -H "Host:ftp.epweike.net" http://10.0.100.92/incoming/epwkdev/docker-compose.tar.gz -o docker-compose.tar.gz
sudo tar -xvf docker-compose.tar.gz -C /usr/local/bin/
sudo chmod +x /usr/local/bin/docker-compose

echo 'install php composer'
sudo cp /data/composer /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

echo 'docker version:'
docker version

echo 'docker-compose version:'
/usr/local/bin/docker-compose version

echo 'composer version:'
/usr/local/bin/composer --version

mkdir -p /data/webroot