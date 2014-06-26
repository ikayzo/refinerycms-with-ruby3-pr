module Refinery
  class Version
<<<<<<< HEAD
    @major = 2
    @minor = 1
    @tiny  = 2
    @build = nil
=======
    @major = 3
    @minor = 0
    @tiny  = 0
    @build = 'dev'
>>>>>>> Plugin-presenters

    class << self
      attr_reader :major, :minor, :tiny, :build

      def to_s
        [@major, @minor, @tiny, @build].compact.join('.')
      end
    end
  end
end
