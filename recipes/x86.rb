#
# Cookbook Name:: java7
# Recipe:: x86
#
# Copyright (C) 2014 Todd Pigram
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Instal javase
windows_package "jre-7u45-windows-i586" do
  source node['url']['x86']
  options "/s"
  installer_type :custom
  action :install
  not_if {::File.exists?(node['java64']['file'])}
  not_if {reboot_pending?}
end

# disable java update
registry_key node['java64']['policy'] do
  values [{
    :name => "EnableJavaUpdate",
    :type => :dword,
    :data => 00000000
    }]
  recursive true
  action :create
end