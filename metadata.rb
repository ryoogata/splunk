name             'splunk'
maintainer       'Ryo Ogata'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures splunk'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.2'

supports "centos"
supports "ubuntu"
supports "amazon"

# == Recipes
#

recipe "splunk::install_splunk",
  "Install splunk"

recipe "splunk::init_setup_splunk",
  "Initialize setup splunk"

recipe "splunk::init_setup_cloudtrail",
  "Initialize setup cloudtrail"

# == Attributes
#
attribute "splunk",
  :display_name => "General Splunk Options",
  :type => "hash"

attribute "splunk/_DOWNLOAD_URL/SPLUNK_RPM",
  :display_name => "Splunk RPM Download URL",
  :description =>
    "Splunk RPM Download URL",
  :required => "required",
  :recipes => ["splunk::install_splunk"]

attribute "splunk/_DOWNLOAD_URL/SPLUNK_DEB",
  :display_name => "Splunk DEB Download URL",
  :description =>
    "Splunk DEB Download URL",
  :required => "optional",
  :recipes => ["splunk::install_splunk"]

attribute "splunk/_DOWNLOAD_URL/SPLUNKAPPFORAWS",
  :display_name => "Splunk App for AWS Download URL",
  :description =>
    "Splunk App for AWS Download URL",
  :required => "optional",
  :recipes => ["splunk::install_splunk"]
