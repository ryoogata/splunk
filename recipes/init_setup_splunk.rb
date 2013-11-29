# splunk の初期化を Selenium で自動化する為のコードを設置
template "/tmp/init_setup_splunk.rb" do
	source "init_setup_splunk.erb"
	variables(
		:loginpassword => node["splunk"]["_LOGINPASSWORD"]
	)
end


# Splunk の初期設定を実施
execute "SetupSplunk" do
	command "/usr/local/bin/rspec /tmp/init_setup_splunk.rb"
end
