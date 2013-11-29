require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "SplunkSelenium" do

  before(:each) do
    @driver = Selenium::WebDriver.for  :remote, :url => "http://localhost:4444/wd/hub", :desired_capabilities => :firefox
    @base_url = "http://localhost:8000/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end

  it "test_splunk_selenium" do
    @driver.get(@base_url + "/ja-JP/account/login?return_to=%2Fja-JP%2F")
    @driver.find_element(:id, "username").clear
    @driver.find_element(:id, "username").send_keys "admin"
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys "changeme"
    @driver.find_element(:css, "input.splButton-primary").click
    @driver.find_element(:id, "newpassword").clear
    @driver.find_element(:id, "newpassword").send_keys "password"
    @driver.find_element(:id, "confirmpassword").clear
    @driver.find_element(:id, "confirmpassword").send_keys "password"
    @driver.find_element(:css, "button.splButton-primary.save-pass-button").click
    sleep 10
    @driver.find_element(:css, "button.close").click
    @driver.find_element(:xpath, "(//a[contains(text(),'Manage Apps')])[2]").click
    sleep 10
    @driver.find_element(:css, "a.splButton-secondary > span").click
    @driver.find_element(:id, "appfile").send_keys "/tmp/SplunkAppforAWS.spl"
    @driver.find_element(:css, "button.splButton-primary").click
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end

  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end

  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
