# docker_vagrant_centos7

## 介绍

这是一个基于 Centos7 的 Vagrant 开发环境，包含 Docker、docker-compose 等程序。本配置在 `Vagrant 2.2.4`，虚拟机为 `VirtualBox 5.2.14` 下测试通过，
其他版本请自行测试。

## 软件架构

- Vagrant
- VirtualBox

## 安装教程

1. 安装 [VirtualBox](https://www.oracle.com/technetwork/cn/server-storage/virtualbox/downloads/index.html) 虚拟机及 [Vagrant](https://www.vagrantup.com/downloads.html) 程序，内网下载地址：
    - 1.1 VirtualBox
        * [Windows](http://ftp.epweike.net/incoming/epwkdev/virtualbox/VirtualBox-5.2.14-123301-Win.exe)
        * [MacOs](http://ftp.epweike.net/incoming/epwkdev/virtualbox/VirtualBox-5.2.14-123301-OSX.dmg)
        * [Ubuntu18.04](http://ftp.epweike.net/incoming/epwkdev/virtualbox/virtualbox-5.2_5.2.14-123301~Ubuntu~18.04_amd64.deb)
        * [Debian9](http://ftp.epweike.net/incoming/epwkdev/virtualbox/virtualbox-5.2_5.2.14-123301~Debian~stretch_amd64.deb)
    - 1.2 Vagrant
        * [Windows](http://ftp.epweike.net/incoming/epwkdev/vagrant/vagrant_2.2.4_x86_64.msi)
        * [MacOs](http://ftp.epweike.net/incoming/epwkdev/vagrant/vagrant_2.2.4_x86_64.dmg)
        * [Centos](http://ftp.epweike.net/incoming/epwkdev/vagrant/vagrant_2.2.4_x86_64.rpm)
        * [Linux](http://ftp.epweike.net/incoming/epwkdev/vagrant/vagrant_2.2.4_linux_amd64.zip)
        * [Debian](http://ftp.epweike.net/incoming/epwkdev/vagrant/vagrant_2.2.4_x86_64.deb)
 
2. 克隆本仓库到本地

    ```
    git clone http://git.epweike.net:3000/epwk/docker_vagrant_centos7.git
    cd docker_vagrant_centos7
    ```

3. 初始化运行配置

    ```
    # windows
    以管理员权限执行 init.bat

    # linux
    chmod +x ./init.sh
    ./init.sh
    ```

4. 设置配置文件

    请手动配置 `config.yaml`

3. 执行建立环境

    ```
    vagrant up
    ```
    
    > 虚拟机创建后分配固定ip: `192.168.50.100`

4. 文件同步说明

   - 虚拟机创建以后会自动同步当前项目的 `data` 目录至虚拟机内的 `/data` 目录，并且创建一个 `/data/webroot` 目录映射到你本机 `config.yaml` 配置的 `webroot` 目录。
   - `必须` 将项目代码克隆至虚拟机内的 `/data/webroot` 目录下。
    
5. 工具使用

    - 初次使用的时候 `tools` 目录下的工具会全部拷贝到 `/usr/local/bin` 目录下并添加可执行权限
    - 欢迎 `Pull Request` 提供各种常用工具
    
## FAQ

- Win7用户在启动过程可能会遇到如下错误提示:

    ```
    The version of powershell currently installed on this host is less than
    the required minimum version. Please upgrade the installed version of
    powershell to the minimum required version and run the command again.
    ```

    - 在下一步之前，请确保计算机用杀毒软件装好安全补丁，防止被利用 `永恒之蓝` 漏洞进行 `powershell` 挖矿，相关参考 [PowershellMiner无文件挖矿](https://xz.aliyun.com/t/2181)
    - 可以通过升级 `powershell` 来解决，下载安装 [升级文件 x64](https://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x64.msu) 或者 [升级文件 x86](https://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x86.msu)，升级成功后重新执行 `vagrant up`
    - 升级 `powershell` 的时候如果遇见 `相关服务未启用` 类似提示，请手动临时启用 `windows update` 服务

- Win10用户在启动过程可能会遇到如下错误提示:

    ```
    Stderr: VBoxManage.exe: error: Failed to open/create the internal network 'HostInterfaceNetworking-VirtualBox Host-Only Ethernet Adapter' (VERR_SUPDRV_COMPONENT_NOT_FOUND).
    VBoxManage.exe: error: Failed to attach the network LUN (VERR_SUPDRV_COMPONENT_NOT_FOUND)
    VBoxManage.exe: error: Details: code E_FAIL (0x80004005), component ConsoleWrap, interface IConsole
    ```
    
    - 可以通过更新virtualbox网络驱动解决：
      * 打开网络共享中心，并转到侧栏中的更改适配器设置
      * 右击VirtualBox Host Only Network网络驱动器
      * 点击配置按钮->驱动程序选项卡->更新驱动程序按钮。
      * 选择浏览我的计算机以查找驱动程序软件选项
      * 选择让我从计算机上的可用驱动程序列表中选取，下一步
      * 应该看到列表中只有 `VirtualBox Host-Only Ethernet Adapter`。选择它并单击下一步。更新驱动程序后，请再次尝试执行 `vagrant up`。

## vagrant 常用命令

1. 查看虚拟机运行状态

```
vagrant status
```

2. 登录虚拟机

```
vagrant ssh epwkdev
```

3. 暂停虚拟机

```
vagrant suspend
```

4. 关闭

```
vagrant halt
```

5. 启动（每次重启电脑后需运行此命令）

```
vagrant up
```

5. 重启

```
vagrant reload
```

6. 销毁

```
vagrant destroy

# 销毁后还需要清理项目下的`.vagrant`目录

# windows
rd /s /q .vagrant

# linux
rm -rf .vagrant
```

## 知识扩展:如何自己创建 vagrant box

#### 1.从 virtualbox 创建虚拟机

- 创建虚拟机，具体如何创建这里就不再详细描述
- 虚拟机设置：2G内存 + 1处理器 + 禁用audio + 禁用usb + 禁用软盘
- 下载 CentOS-7-x86_64-Minimal-1804.iso ，加载到虚拟机光盘，启动虚拟机
- 虚拟机安装界面设置 root 密码设置为 vagrant ，创建 vagrant 账户(勾选管理员)，密码设置为 vagrant

#### 2.进入虚拟机安装依赖

```
# 解决sudo需要密码问题
sudo sed -i '$a\vagrant ALL=(ALL) NOPASSWD: ALL' /etc/sudoers


# 解决ssh链接速度慢的问题
sudo sed -i 's/^#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
sudo systemctl restart sshd


# 配置vagrant公钥
mkdir -p ~/.ssh

cat > ~/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOF

chmod 0700 ~/.ssh/
chmod 0600 ~/.ssh/authorized_keys


# 关闭selinux
sudo setenforce 0
sudo sed -i 's/=enforcing/=disabled/' /etc/selinux/config


# 禁用交换分区
sudo swapoff -a
sudo sed -i '/swap/s/^/#/' /etc/fstab


# 设置阿里云源
sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
sudo curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
sudo yum install -y epel-release
sudo mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup
sudo curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo


# 安装docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sudo yum install -y docker-ce
sudo systemctl enable docker
sudo usermod -aG docker vagrant


# 安装GIT
sudo yum install -y wget openssl-devel curl-devel expat-devel gcc
wget https://github.com/git/git/archive/v2.21.0.tar.gz
tar -zxf v2.21.0.tar.gz
cd git-2.21.0/
make prefix=/usr/local all
sudo make prefix=/usr/local install
cd ..
rm -rf v2.21.0.tar.gz git-2.21.0/


# 安装SMB依赖
sudo yum install -y cifs-utils


# 默认进入 /data 目录
sed -i '$a\cd \/data' ~/.bashrc


# 生成yum缓存
sudo yum clean all
```

#### 3.生成 box 文件

进入到 virtualbox 的虚拟机目录，如：`D:\vbox-system\epwk-centos7`，执行命令：

```
vagrant package --base centos7 --output epwk-centos7.box
```

其中 `centos7` 是你创建的虚拟机的名称，`epwk-centos7.box` 是你导出的 box 文件名称


## 参与贡献

1. Fork 本仓库
2. 新建 feature/xxx 分支
3. 提交代码
4. 新建 Pull Request
