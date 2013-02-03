# https://github.com/fertapric/rails3-mongoid-devise-omniauth/wiki/OmniAuth-Installation-Tutorial

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, 'CONSUMER_KEY', 'CONSUMER_SECRET'

end
