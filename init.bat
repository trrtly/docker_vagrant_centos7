@echo off

title=Vagrant 配置文件初始化
color 2f

echo                       __
echo   ___  ____ _      __/ /__
echo  / _ \/ __ \ ^| /^| / / //_/
echo /  __/ /_/ / ^|/ ^|/ / ,^<
echo \___/ .___/^|__/^|__/_/^|_^|
echo    /_/

if exist %~dp0config.yaml (
    echo 配置文件已经存在，如有变更请编辑[%~dp0config.yaml]后重启vagrant
    echo 正在启动 Vagrant...
    cmd /k "%~d0 && cd %~dp0 && vagrant up"
)

if not "%cd%" == "%windir%\system32" (
       echo 第一次执行请以管理员身份运行
       pause
       exit
)

echo ====================================================================

echo 以下的输出请不要带有中文字符！！！！

set /p git_user=请输入[git config --global user.name]:

set /p git_email=请输入[git config --global user.email]:

set webroot=data/webroot
set /p webroot=请输入挂载的路径，直接回车使用当前项目下的[data/webroot]:

echo 当前 Windows 登录用户为：%username%
set /p smb_password=请输入 Windows 登录密码:

echo 正在生成配置文件[%~dp0config.yaml]...
copy %~dp0config.yaml.example %~dp0config.yaml
echo system: windows>>%~dp0config.yaml
echo git_user: %git_user%>>%~dp0config.yaml
echo git_email: %git_email%>>%~dp0config.yaml
echo webroot: %webroot%>>%~dp0config.yaml
echo smb_username: %username%>>%~dp0config.yaml
echo smb_password: %smb_password%>>%~dp0config.yaml

echo 正在设置禁止自动断开挂载...
net config server /autodisconnect:-1

echo 正在启动 Vagrant...
cmd /k "%~d0 && cd %~dp0 && vagrant up"
