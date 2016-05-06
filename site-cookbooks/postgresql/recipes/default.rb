#
# Cookbook Name:: PostgreSQL
# Recipe:: default
#
# Copyright 2016, Hiroyuki Onaka
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied. See the License for the specific language
# governing permissions and limitations under the License.
 
user "postgres" do
	uid 600
        home "/home/postgres"
	supports :manage_home => true
	shell "/bin/bash"
end

execute "devtools" do
  user "root"
  command 'yum -y groupinstall "Development Tools"'
  action :run
end

%w(readline-devel zlib-devel gcc).each 	do |pkg| 
	yum_package pkg do
		action :install
	end
end

VERSION="9.5.1"
file = "/usr/local/pgsql-#{VERSION}/bin/psql" 

if not File.exists? file then
	remote_file "#{Chef::Config['file_cache_path']}/postgresql-#{VERSION}.tar.gz" do
		action :create_if_missing
		source "https://ftp.postgresql.org/pub/source/v#{VERSION}/postgresql-#{VERSION}.tar.gz"
		notifies :run, 'bash[install]', :immediately
	end
end

bash 'install' do
	flags '-ex'
	cwd "#{Chef::Config['file_cache_path']}"
	user "root"
	group "root"
	code <<-EOH
rm -rf postgresql-#{VERSION}
tar xzf #{Chef::Config['file_cache_path']}/postgresql-#{VERSION}.tar.gz
cd postgresql-#{VERSION}
./configure --prefix=/usr/local/pgsql-#{VERSION}
make
make install
EOH
end

link "/usr/local/pgsql" do
       to "/usr/local/pgsql-#{VERSION}"
end


directory "/var/lib/pgsql" do
	action :create
	owner "postgres"
	group "postgres"
	recursive true
end

if not File.exists? "/var/lib/pgsql/postgresql.conf" then
  bash 'initdb' do
	  flags '-eux'
	  cwd "/var/lib/pgsql"
	  user "postgres"
	  group "postgres"
	  code <<-EOH
/usr/local/pgsql/bin/initdb -D /var/lib/pgsql -E utf8
EOH
  end
end



template "postgres" do
	path "/etc/init.d/postgres"
	owner "root"
	group "root"
	mode 0755
end

service "postgres" do
	action [:enable, :start]
end

