require 'omniauth/openid'
require 'openid/store/filesystem'

Rails.application.config.middleware.use Rack::Session::Cookie
Rails.application.config.middleware.use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp')
