# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"
require 'erb'

Vagrant.require_version ">= 2.2.4"

Vagrant.configure("2") do |config|

  configYaml = File.expand_path(File.dirname(__FILE__)) + "/config.yaml"

  if File.exist? configYaml then
    settings = YAML::load(File.read(configYaml))
  else
    abort "Can not found config file: #{configYaml}"
  end

  # VM 基础配置
  config.vm.box = "epwkdev"
  config.vm.box_url = "http://ftp.epweike.net/incoming/epwkdev/epwk-centos7.box"
  config.vm.box_check_update = false
  config.vm.hostname = "epwkdev"
  config.vm.define "epwkdev"
  config.vm.network "private_network", ip: "192.168.50.100"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "epwkdev"
    vb.memory = settings["memory"] ||= "2048"
    vb.cpus = settings["cpus"] ||= "1"
  end

  # 复制二进制文件
  config.vm.provision "file", source: "bin/", destination: "/tmp/bin"
  config.vm.provision "shell", inline: "cp /tmp/bin/* /usr/local/bin && chmod +x /usr/local/bin/* && rm -rf /tmp/bin/"
  
  # 文件挂载
  os = settings["system"] ||= "windows"
  if os == "windows"
    opts = {create: true, type: "smb", mount_options: ["vers=3.02", "mfsymlinks"]}
    if settings["smb_username"]
      opts[:smb_username] = "#{settings["smb_username"]}"
    end
    if settings["smb_password"]
      opts[:smb_password] = "#{settings["smb_password"]}"
    end
  elsif os == "linux"
    opts = {create: true, type: "nfs", mount_options: ["actimeo=1", "nolock"]}
  else
    abort "Unknown operating system: #{os}"
  end

  webroot = File.expand_path(settings["webroot"] ||= "webroot")
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "data", "/data", opts
  config.vm.synced_folder "#{webroot}", "/data/webroot", opts

  # 自定义目录映射
  if settings["folders"]
    settings['folders'].each do |folder|
        config.vm.synced_folder "#{folder['map']}", "#{folder['to']}", opts
      end
  end
  
  # 配置 GIT
  if !settings["git_user"] || !settings["git_pass"] || !settings["git_email"]
    abort "Git need {git_user} and {git_pass} and {git_email} configure"
  end

  # 记住 GIT 账号密码
  gitProtocol = settings["git_protocol"] ||= "http"
  gitHost = ERB::Util.url_encode(settings["git_host"] ||= "git.epweike.net:3000")
  gituser = ERB::Util.url_encode(settings["git_user"])
  gitPass = ERB::Util.url_encode(settings["git_pass"])
  gitCert = "#{gitProtocol}://#{gituser}:#{gitPass}@#{gitHost}"

  gitInit = <<-SCRIPT
git config --global user.name "#{settings["git_user"]}"
git config --global user.email "#{settings["git_email"]}"
git config --global credential.helper store
echo "#{gitCert}" > ~/.git-credentials
SCRIPT

  config.vm.provision 'shell' do |s|
    s.privileged = false
    s.inline = gitInit
  end

  # 一些初始化配置操作
  config.vm.provision "shell", path: "provision/bootstrap.sh"
end
