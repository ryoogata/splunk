# 必要なパッケージの設置
case node['platform']
when "centos","amazon"
  remote_file "/tmp/splunkforwarder.rpm" do
    source "#{node['splunk']['_DOWNLOAD_URL']['FORWARDER_RPM']}"
  end
when "ubuntu"
  remote_file "/tmp/splunkforwarder.deb" do
    source "#{node['splunk']['_DOWNLOAD_URL']['FORWARDER_DEB']}"
  end
end

# 必要なパッケージのインストール
case node['platform']
when "ubuntu"
  dpkg_package "splunkforwarder" do
    action :install
    source "/tmp/splunkforwarder.deb"
    notifies :run, "execute[start_splunkforwarder]", :immediately
    notifies :run, "execute[enable_boot_splunkforwarder]", :immediately
    notifies :run, "execute[change_admin_password]", :immediately
    notifies :run, "execute[add_forward_server]", :immediately
  end
when "centos","amazon"
  package "splunkforwarder" do
    action :install
    source "/tmp/splunkforwarder.rpm"
    provider Chef::Provider::Package::Rpm
    notifies :run, "execute[start_splunkforwarder]", :immediately
    notifies :run, "execute[enable_boot_splunkforwarder]", :immediately
    notifies :run, "execute[change_admin_password]", :immediately
    notifies :run, "execute[add_forward_server]", :immediately
  end
end

execute "start_splunkforwarder" do
  cwd "/opt/splunkforwarder/bin"
  command "./splunk start --accept-license"
  action :nothing
end

execute "enable_boot_splunkforwarder" do
  cwd "/opt/splunkforwarder/bin"
  command "./splunk enable boot-start"
  action :nothing
end

execute "change_admin_password" do
  cwd "/opt/splunkforwarder/bin"
  command "./splunk edit user admin -password #{node['splunk']['forwarder']['password']} -role admin -auth admin:changeme"
  action :nothing
end

execute "add_forward_server" do
  cwd "/opt/splunkforwarder/bin"
  command "./splunk add forward-server #{node['splunk']['forwarder']['forward_server_host']}:#{node['splunk']['forwarder']['forward_server_port']} -auth admin:#{node['splunk']['forwarder']['password']}"
  action :nothing
end

node['splunk']['forwarder']['monitor'].to_a.each do |monitor|
  execute "add_monitor" do
    cwd "/opt/splunkforwarder/bin"
    command "./splunk add monitor #{monitor}"
    only_if { not node['splunk']['forwarder']['monitor'].empty? }
    not_if "/opt/splunkforwarder/bin/splunk list monitor | grep '#{monitor}$'"
  end
end
