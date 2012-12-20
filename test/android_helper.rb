class MiniTest::Spec
  before do
    # stub writeing to the manifest file
  end
end

FAKE_ANDROID_PROJECT = "fake_project"
FAKE_ANDROID_PROJECT_DIR = "#{File.dirname(__FILE__)}/fakes/android/#{FAKE_ANDROID_PROJECT}"

def delete_android_project
  if File.directory? FAKE_ANDROID_PROJECT_DIR
    `rm -rf #{FAKE_ANDROID_PROJECT_DIR}`
  end
end

def create_android_project
  unless File.directory? FAKE_ANDROID_PROJECT_DIR
    `android create project --path #{FAKE_ANDROID_PROJECT_DIR} --name #{FAKE_ANDROID_PROJECT} --target android-15 --package be.potemkin.android -a MainActivity`
  end
end

def recreate_android_project
  delete_android_project
  create_android_project
end
