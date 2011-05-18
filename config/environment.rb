# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PoolBitcomexCom::Application.initialize!
PoolBitcomexCom::Application.configure do
	config.action_dispatch.session = {
		:key    => '_app_session',
		:secret => '05a7ff41b639b94ee5509ee6c9f8775fd1a79a2b'
	}
end
