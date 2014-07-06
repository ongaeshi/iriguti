Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :pocket, ENV['POCKET_KEY']
end  
