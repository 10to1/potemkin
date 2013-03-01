begin
  require 'cloudapp'
  require 'cloudapp/credentials'
  require 'cloudapp/cli/options'
  require 'cloudapp/cli/prompt'
  require 'cloudapp/service'
  require "shijt"
rescue LoadError => e
  puts "CloudApp gem not installed. \n Please run `gem install cloudapp`"
end

module Potemkin
  module Deployer
    class CloudApp < Base

      attr_accessor :token

      def initialize(*args)
        super(args)
        raise "Please set cloudapp_email and cloudapp_password" unless credentials_present?
        @token = config.token ? config.token : token_from_credentials
      end

      def config
        Potemkin.config
      end

      def token_from_credentials
        ::CloudApp::Service.token_for_account(config.cloudapp_email, config.cloudapp_password)
      end

      def credentials_present?
        (config.cloudapp_email && config.cloudapp_password) || config.cloudapp_token
      end

    end
  end
end
