#
# Cookbook Name:: yumsetup 
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

yum_package "yum-fastestmirror" do
	action :install
end

execute "yum-update" do
	user "root"
	command "yum -y update"
	action :run
end

yum_package "java-1.8.0-openjdk-devel" do
	action :install
end
