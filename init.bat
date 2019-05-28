@echo off

if "%cd%" == "%windir%\system32" (
    echo.
    copy /-y %~dp0config.yaml.example %~dp0config.yaml
    net config server /autodisconnect:-1
    echo 初始化完成，请配置 config.yaml 后执行 'vagrant up'
    echo.
) else (
    echo.
    echo 请以管理员身份运行!
    echo.
)

pause