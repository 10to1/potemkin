module Potemkin
  class Configuration < OpenStruct
    def sdk_root
      ENV["ANDROID_SDK_ROOT"]
    end
  end
end
