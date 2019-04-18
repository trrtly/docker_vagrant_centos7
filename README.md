# docker_vagrant_centos7

#### 介绍
这是一个基于centos7的vagrant开发环境，包含docker、docker-compose等程序。本配置在`Vagrant 2.2.*`，虚拟机为`VirtualBox 5.2.*`下测试通过，
其他版本请自行测试。

#### 软件架构
- vagrant
- virtualbox
- openssh

#### 安装教程

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

2. 安装openssh
    - 4.1 Windows
        * 以管理员权限登录系统
        * 如果没有设置管理员密码，通过控制面板设置一个（密码是必须的）
        * 在C盘创建cygwin文件夹（**c:\cygwin**）
        * 下载[Cygwin](http://ftp.epweike.net/incoming/epwkdev/cygwin-x86_64.exe)，保存至**c:\cygwin**
        * 运行**c:\cygwin\cygwin-x86_64.exe**
        * Install from the Internet保存路径：**c:\cygwin**
        * For Local Package Directory使用路径：**c:\cygwin**
        * 从列表选择一个网址（比如第一个）
        * 在**Select Packages**页，view选**"Full"**，Search框输入：**openssh**
        * 选中包名为**openssh**的行，单击对应New列的下拉三角箭头选择最新版本，并选中Src列的复选框
        * 如果是首次安装，下一步安装完成后可以选择在桌面创建快捷方式
        * 右击**计算机>属性>高级系统设置>环境变量**
        * 在系统变量标签下，点击新建，添加**CYGWIN**为变量名，**ntsec**为变量值
        * 在系统变量标签下，下拉至Path，点击编辑，添加**;c:\cygwin\bin**至变量值的末尾，注意前面有分号
        * 右击桌面cygwin图标选择以管理员身份运行，输入**ssh-host-config**
        * Privilege Separation?” Yes
        * “Create local user SSHd?” Yes
        * Install SSHd as a service?” Yes
        * CYGWIN = ” 输入 ntsec
        * 配置完成以后输入**net start sshd**启动ssh服务
        * 输入**ssh localhost**测试安装成功
    - 4.2 Linux
        * ubuntu或debian系统：`sudo apt-get install openssh-server`
        * 其他系统一般默认安装了openssh-server

3. 手动添加centos/7 box
```
vagrant box add http://ftp.epweike.net/incoming/epwkdev/CentOS-7-x86_64-Vagrant-1902_01.VirtualBox.box --name centos/7
```

4. 克隆本仓库到本地
```
git clone http://git.epweike.net:3000/epwk/docker_vagrant_centos7.git
cd docker_vagrant_centos7
```

5. 安装sshfs插件
```
vagrant plugin install vagrant-sshfs
```

6. 执行建立环境
```
vagrant up
```

- Win7用户在启动过程可能会遇到如下错误提示:
    ```
    The version of powershell currently installed on this host is less than
    the required minimum version. Please upgrade the installed version of
    powershell to the minimum required version and run the command again.
    ```
    可以通过升级powershell来解决,下载[升级文件](http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x64.msu)，升级成功后重新执行`vagrant up`

- Win10用户在启动过程可能会遇到如下错误提示:
    ```
    Stderr: VBoxManage.exe: error: Failed to open/create the internal network 'HostInterfaceNetworking-VirtualBox Host-Only Ethernet Adapter' (VERR_SUPDRV_COMPONENT_NOT_FOUND).
    VBoxManage.exe: error: Failed to attach the network LUN (VERR_SUPDRV_COMPONENT_NOT_FOUND)
    VBoxManage.exe: error: Details: code E_FAIL (0x80004005), component ConsoleWrap, interface IConsole
    ```
    可以通过更新virtualbox网络驱动解决：
      * 打开网络共享中心，并转到侧栏中的更改适配器设置
      * 右击VirtualBox Host Only Network网络驱动器
      * 点击配置按钮->驱动程序选项卡->更新驱动程序按钮。
      * 选择浏览我的计算机以查找驱动程序软件选项
      * 选择让我从计算机上的可用驱动程序列表中选取，下一步
      * 应该看到列表中只有`VirtualBox Host-Only Ethernet Adapter`。选择它并单击下一步。更新驱动程序后，请再次尝试执行`vagrant up`。

7. 文件同步说明
   - 虚拟机创建以后会自动同步当前项目所在目录至虚拟机内的/data目录
   - 可以在项目目录下创建webroot目录，将项目代码克隆至webroot目录下，对应虚拟机内的/data/webroot
   - 例如，安装dev.epwk.env：

    ```
    # 创建 webroot 目录
    mkdir webroot
    cd webroot
    # 克隆 dev.epwk.env 仓库
    git clone http://git.epweike.net:3000/epwk/dev.epwk.env.git
    vagrant ssh
    cd /data/webroot/dev.epwk.env
    cp .env-example .env
    docker-compose up -d
    ```
8. 虚拟机创建后分配固定ip: `192.168.50.100`


#### 使用说明

##### 在docker_vagrant_centos7项目目录下执行命令

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
vagrant reload
```

5. 重启
```
vagrant reload
```

6. 销毁
```
vagrant destroy
# 销毁后还需要清理项目下的.vagrant目录
# windows
rd /s /q .vagrant
# linux
rm -rf .vagrant
```

#### 参与贡献

1. Fork 本仓库
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request
