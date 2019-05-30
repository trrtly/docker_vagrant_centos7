@echo off

title=Vagrant �����ļ���ʼ��
color 2f

echo                       __
echo   ___  ____ _      __/ /__
echo  / _ \/ __ \ ^| /^| / / //_/
echo /  __/ /_/ / ^|/ ^|/ / ,^<
echo \___/ .___/^|__/^|__/_/^|_^|
echo    /_/

if exist %~dp0config.yaml (
    echo �����ļ��Ѿ����ڣ����б����༭[%~dp0config.yaml]������vagrant
    echo �������� Vagrant...
    cmd /k "%~d0 && cd %~dp0 && vagrant up"
)

if not "%cd%" == "%windir%\system32" (
       echo ��һ��ִ�����Թ���Ա�������
       pause
       exit
)

echo ====================================================================

echo ���µ�����벻Ҫ���������ַ���������

set /p git_user=������[git config --global user.name]:

set /p git_email=������[git config --global user.email]:

set webroot=data/webroot
set /p webroot=��������ص�·����ֱ�ӻس�ʹ�õ�ǰ��Ŀ�µ�[data/webroot]:

echo ��ǰ Windows ��¼�û�Ϊ��%username%
set /p smb_password=������ Windows ��¼����:

echo �������������ļ�[%~dp0config.yaml]...
copy %~dp0config.yaml.example %~dp0config.yaml
echo system: windows>>%~dp0config.yaml
echo git_user: %git_user%>>%~dp0config.yaml
echo git_email: %git_email%>>%~dp0config.yaml
echo webroot: %webroot%>>%~dp0config.yaml
echo smb_username: %username%>>%~dp0config.yaml
echo smb_password: %smb_password%>>%~dp0config.yaml

echo �������ý�ֹ�Զ��Ͽ�����...
net config server /autodisconnect:-1

echo �������� Vagrant...
cmd /k "%~d0 && cd %~dp0 && vagrant up"
