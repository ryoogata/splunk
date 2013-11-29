# splunk のapp for aws の初期化を Selenium で自動化する為のコードを設置
template "/tmp/init_setup_cloudtrail.rb" do
	source "init_setup_cloudtrail.erb"
	variables(
		:loginpassword => node["splunk"]["_LOGINPASSWORD"],
		:splunkconfigname => node["splunkappforaws"]["_NAME"],
		:accesskey => node["aws"]["_ACCESS_KEY"],
		:secretkey => node["aws"]["_SECRET_KEY"],
		:sqsqueue => node["aws"]["sqs"]["_SQS_QUEUE"],
		:sqsqueueregion => node["aws"]["sqs"]["_SQS_QUEUE_REGION"]
	)
end


# Splunk の初期設定を実施
execute "SetupSplunk" do
	command "/usr/local/bin/rspec /tmp/init_setup_cloudtrail.rb"
end
