# 必要なパッケージの設置
case node['platform']
when "centos"
  remote_file "/tmp/splunk.rpm" do
    source "#{node['splunk']['_DOWNLOAD_URL']['SPLUNK_RPM']}"
  end
when "ubuntu"
  remote_file "/tmp/splunk.deb" do
    source "#{node['splunk']['_DOWNLOAD_URL']['SPLUNK_DEB']}"
  end
end


# Splunk App for AWS の設置
remote_file "/tmp/SplunkAppforAWS.spl" do
	source "#{node['splunk']['_DOWNLOAD_URL']['SPLUNKAPPFORAWS']}"
end


# 必要なパッケージのインストール
case node['platform']
when "ubuntu"
  dpkg_package "splunk" do
    action :install
    source "/tmp/splunk.deb"
  end
when "centos"
  package "splunk" do
    action :install
    source "/tmp/splunk.rpm"
    provider Chef::Provider::Package::Rpm
  end
end

# license-eula.txt の削除
file "/opt/splunk/license-eula.txt" do
  action :delete
end

# splunk の初期化
execute "boot-start" do
  command "/opt/splunk/bin/splunk enable boot-start --answer-yes"
end

# splunk の起動
service "splunk" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
