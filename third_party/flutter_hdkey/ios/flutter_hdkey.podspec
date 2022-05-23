#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_hdkey.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_hdkey'
  s.version          = '0.0.2'
  s.summary          = 'Flutter sdk for HDKey'
  s.description      = 'Flutter sdk for HDKey'
  s.homepage         = 'https://github.com/dabankio/flutter_hdkey'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Dabank' => 'sugar@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  # s.vendored_frameworks = 'SDK.framework'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
