#
# Cookbook Name:: open_broadcast_encoder
# Recipe:: default
#
# Copyright 2012, Aaron Cruz (aaron@aaroncruz.com)
#
# All rights reserved - Do Not Redistribute
#

# Dependencies
%w(libtwolame-dev libzvbi0 libzvbi-dev libzvbi-common).each do |lib|
  package lib do
    action :install
  end
end

### FDK-AAC
#name  = 'fdk-aac'
#owner = 'kierank'
#
#git "Git #{name}" do
  #repository "git://github.com/#{owner}/#{name}.git"
  #reference 'master'
  #destination "#{node[:obe][:git_directory]}/#{name}"
  #action :sync
#end
#
#bash "Install #{name}" do
  #code <<-COMMAND
    #cd #{node[:obe][:git_directory]}/#{name}
    #autoreconf -i && ./configure --prefix=/usr
    #make -j5
    #make install
  #COMMAND
#end
#
## LIBAV
#name  = 'libav-obe-dev2'
#owner = 'kierank'
#
#git "Git #{name}" do
  #repository "git://github.com/#{owner}/#{name}.git"
  #reference 'master'
  #destination "#{node[:obe][:git_directory]}/#{name}"
  #action :sync
#end
#
#bash "Install #{name}" do
  #code <<-COMMAND
    #cd #{node[:obe][:git_directory]}/#{name}
    #./configure --prefix=/usr --enable-gpl --enable-nonfree --enable-libfdk-aac --disable-swscale-alpha --disable-avdevice
    #make -j5
    #make install
  #COMMAND
#end

### LIBX264
#name  = 'x264-obe'
#owner = 'kierank'
#
#git "Git #{name}" do
  #repository "git://github.com/#{owner}/#{name}.git"
  #reference 'master'
  #destination "#{node[:obe][:git_directory]}/#{name}"
  #action :sync
#end
#
#bash "Install #{name}" do
  #code <<-COMMAND
    #cd #{node[:obe][:git_directory]}/#{name}
    #./configure --prefix=/usr
    #make -j5
    #make install-lib-static
  #COMMAND
#end
#
## LIBMPEGTS
#name  = 'libmpegts'
#owner = 'kierank'
#
#git "Git #{name}" do
  #repository "git://github.com/#{owner}/#{name}.git"
  #reference 'master'
  #destination "#{node[:obe][:git_directory]}/#{name}"
  #action :sync
#end
#
#bash "Install #{name}" do
  #code <<-COMMAND
    #cd #{node[:obe][:git_directory]}/#{name}
    #./configure --prefix=/usr
    #make -j5
    #make install
  #COMMAND
#end

# Open Broadcast Encoder
name  = 'broadcastencoder'
owner = 'kierank'

git "Git #{name}" do
  repository "git://github.com/#{owner}/#{name}.git"
  reference 'master'
  destination "#{node[:obe][:git_directory]}/#{name}"
  action :sync
end

bash "Install #{name}" do
  code <<-COMMAND
    cd #{node[:obe][:git_directory]}/#{name}
    ./configure --prefix=/usr
    make -j5
    make install
  COMMAND
end
