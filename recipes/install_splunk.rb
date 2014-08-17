# 必要なパッケージの設置
case node['platform']
when "centos","amazon"
  remote_file "/tmp/splunk.rpm" do
    source "#{node['splunk']['_DOWNLOAD_URL']['SPLUNK_RPM']}"
  end
when "ubuntu"
  remote_file "/tmp/splunk.deb" do
    source "#{node['splunk']['_DOWNLOAD_URL']['SPLUNK_DEB']}"
  end
end

# 必要なパッケージのインストール
case node['platform']
when "ubuntu"
  dpkg_package "splunk" do
    action :install
    source "/tmp/splunk.deb"
    notifies :run, "execute[boot-start]", :immediately
  end
when "centos","amazon"
  package "splunk" do
    action :install
    source "/tmp/splunk.rpm"
    provider Chef::Provider::Package::Rpm
    notifies :run, "execute[boot-start]", :immediately
  end
end

# splunk の初期化
execute "boot-start" do
  command "/opt/splunk/bin/splunk enable boot-start --accept-license"
  action :nothing
end

# splunk の起動
service "splunk" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
