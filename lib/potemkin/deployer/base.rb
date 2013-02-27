module Potemkin
  module Deployer
    class Base
      attr_accessor :build_path

      def initialize(build_path)
        self.build_path = build_path
      end
    end

  end
end
