#
# Be sure to run `pod lib lint QTableKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QTableKit'
  s.version          = '1.0'
  s.summary          = 'Make static UITableViewCell more conventient .'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Make static UITableViewCell more conventient,useful in loginVC\RegisterVC
                       DESC

  s.homepage         = 'https://github.com/QDong415/QTableKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'd19890415' => '285275534@qq.com' }
  s.source           = { :git => 'https://github.com/QDong415/QTableKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'QTableKit/Classes/**/*'
  s.swift_versions = ['5.0', '5.1', '5.2', '5.3']
  # s.resource_bundles = {
  #   'QTableKit' => ['QTableKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
