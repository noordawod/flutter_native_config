#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_native_config'
  s.version          = '1.0.0'
  s.summary          = 'A plugin to access native configuration for both Android and iOS from Flutter.'
  s.description      = <<-DESC
For some third party integrations, for example Google and Facebook, the API keys are usually stored
in the native realm -- namely **AndroidManifest.xml** and **Info.plist** -- and there's no way to
access these values from Flutter. Until now, that it :)

This plugin allows you to access those values directly from Flutter so you don't have to include then
in Dart code in addition to the native realm.
                       DESC
  s.homepage         = 'https://github.com/noordawod/flutter_native_config'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Noor Dawod' => 'noor@fine47.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end
