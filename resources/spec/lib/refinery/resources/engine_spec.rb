require 'spec_helper'

module Refinery
  describe Resources do
    # these are the values that are tested
    Refinery::Resources.configure do |config|
      config.dragonfly_datastore_root_path = 'resources'
      config.dragonfly_url_host = 'myhost'
      config.dragonfly_url_format = '/a/b/c/d'
      # config.dragonfly_verify_urls = false
    end
    it_has_behaviour 'Creates a dragonfly App:'
    it_has_behaviour 'adds the dragonfly app to the middleware stack'
  end
end
