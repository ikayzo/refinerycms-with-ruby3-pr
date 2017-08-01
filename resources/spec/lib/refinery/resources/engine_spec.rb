require 'spec_helper'

module Refinery
  describe Resources do
    # these are the values that are tested
    it_has_behaviour 'Creates a dragonfly App:'
    it_has_behaviour 'adds the dragonfly app to the middleware stack'
  end
end
