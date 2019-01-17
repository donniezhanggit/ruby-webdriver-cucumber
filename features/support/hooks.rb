# Created by Viacheslav (Slava) Skryabin 01/01/2016
require_relative 'test_context'
require 'em/pure_ruby'
require "selenium-webdriver"
require "selenium-cucumber"
require "test/unit"
require "time"
require 'page-object'

Test::Unit::AutoRunner.need_auto_run = false
include Test::Unit::Assertions

# World(PageObject::PageFactory)

$tc = TestContext.new
$driver = $tc.driver

Before do
  @browser = $driver
  @browser.manage.delete_all_cookies
end

After do |scenario|
  if scenario.failed?
    begin
      scenario_name = "Scenario"
      scenario.source_tag_names.each do |tag_name|
        scenario_name = scenario_name + "_" + tag_name + "_" + scenario.name.tr(" ", "_")
      end
      @browser.save_screenshot("./output/#{scenario_name}.png")
      embed("./output/#{scenario_name}.png", "image/png", "Screenshot of " + @browser.current_url)
    rescue => exception
      # do nothing
    end
  end
end

