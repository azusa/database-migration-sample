#
# Cookbook Name:: database
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


PSQL="/usr/local/pgsql/bin/psql"

execute "create-role" do
    exists = <<-EOH
        su - postgres -c "#{PSQL} -c\\"SELECT * FROM pg_user WHERE usename='ut'\\" | grep -c ut"
    EOH
    command <<-EOC
        su - postgres -c "#{PSQL} -c\\"CREATE ROLE ut WITH LOGIN PASSWORD '#{node['password']['ut']}';\\""
    EOC
    not_if exists 
end

execute "create-role-development" do
    exists = <<-EOH
        su - postgres -c "#{PSQL} -c\\"SELECT * FROM pg_user WHERE usename='development'\\" | grep -c development"
    EOH
    command <<-EOC
        su - postgres -c "#{PSQL} -c\\"CREATE ROLE development WITH LOGIN PASSWORD '#{node['password']['development']}';\\""
    EOC
    not_if exists 
end

execute "create-database" do
    exists = <<-EOH
        su - postgres -c "#{PSQL} -c\\"SELECT * FROM pg_database WHERE datname = 'ut'\\" | grep -c ut"
    EOH
    command <<-EOC
        su - postgres -c "#{PSQL} -c\\"CREATE DATABASE ut OWNER ut ENCODING 'UTF8' ;\\""
    EOC
    not_if exists 
end

execute "create-database-development" do
    exists = <<-EOH
        su - postgres -c "#{PSQL} -c\\"SELECT * FROM pg_database WHERE datname = 'development'\\" | grep -c development"
    EOH
    command <<-EOC
        su - postgres -c "#{PSQL} -c\\"CREATE DATABASE development OWNER development ENCODING 'UTF8' ;\\""
    EOC
    not_if exists 
end

template "pg_hba.conf" do
	path "/var/lib/pgsql/pg_hba.conf"
        owner "postgres"
	group "postgres"
	mode 0644
	notifies :restart, "service[postgres]"
end

template "postgresql.conf" do
	path "/var/lib/pgsql/postgresql.conf"
        owner "postgres"
	group "postgres"
	mode 0644
	notifies :restart, "service[postgres]"
end

