# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  # with Minitest::Unit
  watch(%r|^test/(.*)\/?(.*)_test\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|) { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r|^test/helper\.rb|) { "test" }
  watch(%r|^lib/potemkin\.rb|) { "test" }

  watch(%r|^lib/potemkin/builder/(.*)\.rb|) { |m| "test/builder_#{m[1]}_test.rb" }
end
