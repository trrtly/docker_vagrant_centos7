@echo off

if "%cd%" == "%windir%\system32" (
    echo.
    copy /-y %~dp0config.yaml.example %~dp0config.yaml
    net config server /autodisconnect:-1
    echo ��ʼ����ɣ������� config.yaml ��ִ�� 'vagrant up'
    echo.
) else (
    echo.
    echo ���Թ���Ա�������!
    echo.
)

pause