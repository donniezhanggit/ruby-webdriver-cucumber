class TestContext

  def driver
    chrome_driver_path = "./drivers/chromedriver"
    firefox_driver_path = "./drivers/geckodriver"
    extension = ""
    if Gem.win_platform?
      extension = ".exe"
    end
    Selenium::WebDriver::Chrome.driver_path = chrome_driver_path + extension
    Selenium::WebDriver::Firefox.driver_path = firefox_driver_path + extension
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
    # chrome_options.add_argument("--headless")
    # chrome_options.add_argument("--window-size=1920,1080")
    driver = Selenium::WebDriver.for(:chrome, detach: false, options: chrome_options)
    driver.execute_script("alert('Bringing to foreground!')")
    driver.switch_to.alert.accept

    return driver
  end
end