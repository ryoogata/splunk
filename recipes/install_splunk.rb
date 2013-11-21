# 必要なパッケージの設置
case node['platform']
when "centos"
	remote_file "/tmp/splunk-6.0-182037-linux-2.6-x86_64.rpm" do
		source "https://s3-us-west-1.amazonaws.com/us-west-1.yggdrasillnetwork.net/rpm/splunk-6.0-182037-linux-2.6-x86_64.rpm"
	end
when "ubuntu"
	remote_file "/tmp/splunk-6.0-182037-linux-2.6-amd64.deb" do
		source "https://s3-us-west-1.amazonaws.com/us-west-1.yggdrasillnetwork.net/rpm/splunk-6.0-182037-linux-2.6-amd64.deb"
	end
end


# Splunk App for AWS の設置
remote_file "/tmp/SplunkAppforAWS.spl" do
	source "https://s3-us-west-1.amazonaws.com/us-west-1.yggdrasillnetwork.net/rpm/SplunkAppforAWS.spl"
end


# 必要なパッケージのインストール
case node['platform']
when "ubuntu"
	dpkg_package "splunk" do
		action :install
		source "/tmp/splunk-6.0-182037-linux-2.6-amd64.deb"
	end
when "centos"
	package "splunk" do
		action :install
		source "/tmp/splunk-6.0-182037-linux-2.6-x86_64.rpm"
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
