# Created by Viacheslav (Slava) Skryabin 01/01/2016
require "em/pure_ruby"
require "selenium-webdriver"
require "selenium-cucumber"
require "test/unit"
require "time"

Test::Unit::AutoRunner.need_auto_run = false
include Test::Unit::Assertions

# Will be executed before beginning of all Scenarios - after initial Cucumber configuration
AfterConfiguration do
  chrome_driver_path = "./drivers/chromedriver"
  if Gem.win_platform?
    chrome_driver_path = "./drivers/chromedriver.exe"
  end
  Selenium::WebDriver::Chrome.driver_path = chrome_driver_path
  chrome_options = Selenium::WebDriver::Chrome::Options.new
  chrome_options.add_argument("--start-maximized")
  chrome_options.add_argument("--disable-cache")
  chrome_options.add_argument("--ignore-certificate-errors")
  chrome_options.add_argument("--disable-popup-blocking")
  chrome_options.add_argument("--test-type")
  chrome_options.add_argument("--disable-download-notification")
  chrome_options.add_argument("--disable-popup-blocking")
  chrome_options.add_argument("--disable-translate")
  chrome_options.add_argument("--dns-prefetch-disable")
  if $driver.nil?
    $driver = Selenium::WebDriver.for(:chrome, detach: false, options: chrome_options)
    # below needed for browser to get to foreground
    $driver.execute_script("alert('Bringing to foreground!')")
    $driver.switch_to.alert.accept
  end
end

# Will be executed before start of each Scenario
Before do
  if !$driver.nil?
    $driver.manage.delete_all_cookies
  end
end

# Will be executed before start of specific Scenario with mentioned tags
Before("@one1 or @one2") do

end

# Will be executed after finish of each Scenario
After do |scenario|
  if scenario.failed?
    begin
      scenario_name = "Scenario"
      scenario.source_tag_names.each do |tag_name|
        scenario_name = scenario_name + "_" + tag_name + "_" + scenario.name.tr(" ", "_")
      end
      $driver.save_screenshot("./output/#{scenario_name}.png")
      embed("./output/#{scenario_name}.png", "image/png", "Screenshot of " + $driver.current_url)
    rescue => exception
      # do nothing
    end
  end
end

# Will be executed after each Scenario Step
AfterStep do

end

# Will be executed after all Scenarios are finished and completed
at_exit do
  if !$driver.nil? && $driver.browser != :chrome
    $driver.quit
  end
end
