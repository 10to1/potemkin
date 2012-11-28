module Potemkin
  class Builder

    # No environment variables by default
    def env_vars
      {}
    end

    # Will build the actual APK
    def build
      logger.describe "creating build"
      with_env_vars(env_vars) { Potemkin.run build_command }
    end

    def clean
      logger.describe "cleaning build"
      with_env_vars(env_vars) { Potemkin.run clean_command }
    end

    # Takes a hash and a block, wrapping the block with the env variables
    # found in the hash.
    def with_env_vars(env_vars)
      old_values = {}
      env_vars.each do |key,new_value|
        old_values[key] = ENV[key]
        ENV[key] = new_value
      end

      return_value = yield

      env_vars.each_key do |key|
        ENV[key] = old_values[key]
      end

      return_value
    end

    # Returns the config, mainly here to mock in tests
    def config
      Potemkin.config
    end

    # Returns the logger, mainly here to mock in tests
    def logger
      Potemkin.logger
    end

  end
end
