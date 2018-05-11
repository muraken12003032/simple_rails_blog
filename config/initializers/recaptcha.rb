Recaptcha.configure do |config|
  #config.site_key = '6LdWllgUAAAAAEGb3Dwo_Z7eJID7BjxA7Z1vkqto'
  #config.secret_key = '6LdWllgUAAAAAJ8T3p0cJO_I3dHfX2t46SNIF3qk'
  config.site_key = ENV["RECAPTCHA_SITEKEY"]
  config.secret_key = ENV["RECAPTCHA_SECRETKEY"]
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end