#
# Cookbook Name:: open_broadcast_encoder
# Recipe:: default
#
# Copyright 2012, Aaron Cruz (aaron@aaroncruz.com)
#
# All rights reserved - Do Not Redistribute
#
template "#{node[:obe][:cli][:init_path]}/obe" do
  source "obectl"
  owner "root"
  group "root"
  mode "0755"
  notifies :restart, "service[obe]"
end

service "obe" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

# Dependencies
%w(libtwolame-dev libzvbi0 libzvbi-dev libzvbi-common).each do |lib|
  package lib do
    action :install
  end
end

owner = 'kierank'

### FDK-AAC
name  = 'fdk-aac'

git "Git #{name}" do
  not_if file_exists? "lib", "libfdk-aac.a"
  repository "git://github.com/#{owner}/#{name}.git"
  reference 'master'
  destination "#{node[:obe][:git][:directory]}/#{name}"
  action :export
end

bash "Install #{name}" do
  not_if file_exists? "lib", "libfdk-aac.a"
  cmd = <<-COMMAND
    cd #{node[:obe][:git][:directory]}/#{name}
    make distclean
    autoreconf -i && LDFLAGS="-I#{node[:obe][:prefix]}/include" CFLAGS="-L#{node[:obe][:prefix]}/lib" ./configure --prefix=#{node[:obe][:prefix]}
    make -j5
    make install
  COMMAND
  block do
    Chef::Log.info("COMMAND: #{cmd}")
  end
  code cmd
end

# LIBAV
name  = 'libav-obe-dev2'

git "Git #{name}" do
  not_if file_exists? "lib", "libavcodec.a"
  repository "git://github.com/#{owner}/#{name}.git"
  reference 'master'
  destination "#{node[:obe][:git][:directory]}/#{name}"
  action :export
end

bash "Install #{name}" do
  not_if file_exists? "lib", "libavcodec.a"
  cmd = <<-COMMAND
    cd #{node[:obe][:git][:directory]}/#{name}
    make distclean
    LDFLAGS="-L#{node[:obe][:prefix]}/lib" CFLAGS="-I#{node[:obe][:prefix]}/include" ./configure --prefix=#{node[:obe][:prefix]} --enable-gpl --enable-nonfree --enable-libfdk-aac --disable-swscale-alpha --disable-avdevice
    make -j5
    make install
  COMMAND
  block do
    Chef::Log.info("COMMAND: #{cmd}")
  end
  code cmd
end
#
## LIBX264
name  = 'x264-obe'

git "Git #{name}" do
  not_if file_exists? "lib", "libx264.a"
  repository "git://github.com/#{owner}/#{name}.git"
  reference 'master'
  destination "#{node[:obe][:git][:directory]}/#{name}"
  action :export
end

bash "Install #{name}" do
  not_if file_exists? "lib", "libx264.a"
  cmd = <<-COMMAND
    cd #{node[:obe][:git][:directory]}/#{name}
    make distclean
    LDFLAGS="-I#{node[:obe][:prefix]}/include" CFLAGS="-L#{node[:obe][:prefix]}/lib"./configure --prefix=#{node[:obe][:prefix]}
    make -j5
    make install-lib-static
  COMMAND
  block do
    Chef::Log.info("COMMAND: #{cmd}")
  end
  code cmd
end

# LIBMPEGTS
name  = 'libmpegts'

git "Git #{name}" do
  not_if file_exists? "lib", "libmpegts.a"
  repository "git://github.com/#{owner}/#{name}.git"
  reference 'master'
  destination "#{node[:obe][:git][:directory]}/#{name}"
  action :export
end

bash "Install #{name}" do
  not_if file_exists? "lib", "libmpegts.a"
  cmd = <<-COMMAND
    cd #{node[:obe][:git][:directory]}/#{name}
    make distclean
    LDFLAGS="-I#{node[:obe][:prefix]}/include" CFLAGS="-L#{node[:obe][:prefix]}/lib"./configure --prefix=#{node[:obe][:prefix]}
    make -j5
    make install
  COMMAND
  block do
    Chef::Log.info("COMMAND: #{cmd}")
  end
  code cmd
end

# Open Broadcast Encoder
name  = 'broadcastencoder'

git "Git #{name}" do
  not_if file_exists? "lib", "libobe.a"
  repository "git://github.com/#{owner}/#{name}.git"
  reference node[:obe][:git][:branch]
  destination "#{node[:obe][:git][:directory]}/#{name}"
  action :export
end

bash "Install #{name}" do
  not_if file_exists? "lib", "libobe.a"
  cmd = <<-COMMAND
    cd #{node[:obe][:git][:directory]}/#{name}
    make distclean
    LDFLAGS="-L#{node[:obe][:prefix]}/lib" CFLAGS="-I#{node[:obe][:prefix]}/include" ./configure --prefix=#{node[:obe][:prefix]}
    make -j5
    make install
  COMMAND
  block do
    Chef::Log.info("COMMAND: #{cmd}")
  end
  code cmd
end

def file_exists? dir, file
  "test -f #{node[:obe][:prefix]}/#{dir}/#{file}"
end
