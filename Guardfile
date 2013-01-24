# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  # with Minitest::Unit
  watch(%r|^test/(.*)\/?(.*)_test\.rb|)
  watch(%r|^test/helper\.rb|) { "test" }
  watch(%r|^lib/potemkin\.rb|) { "test" }
  # Map lib/potemkin/ios/something.rb test/ios_something_test.rb
  watch(%r|^lib\/potemkin\/(.*)\/(.*)\.rb|) { |m| "test/#{m[1]}_#{m[2]}_test.rb" }
  # Map lib/potemkin/logger.rb test/logger_test.rb
  watch(%r|^lib\/potemkin\/(.*)\.rb|) { |m| "test/#{m[1]}_test.rb" }
end
