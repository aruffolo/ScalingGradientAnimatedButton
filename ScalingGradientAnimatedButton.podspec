#
# Be sure to run `pod lib lint ScalingGradientAnimatedButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScalingGradientAnimatedButton'
  s.version          = '0.1.1'
  s.summary          = 'A subview of UIView that provide a custom Button with a gradient and scale animation'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC 'a subclass of UIView custom button with scale gradient 3D like animation'

TODO: 'This class provides a view that can be used as UIButton. Anonimous callbacks return the tag of the view when tap and long
press events are fired. The view can be initialized prvoviding a gradient colors and positions for the unselected state and for the selected state. A scale parameter also is
used to device if the view should increase or decrease his size, giving it a 'moving forward' or 'moving backward' illusion.
A second init function provided just an unselected and selected color.
An enum is used to let the user choose a margin to which the button should stick while moving (if any)'
DESC


  s.homepage         = 'https://github.com/aruffolo/ScalingGradientAnimatedButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Antonio Ruffolo' => 'antonioruffolo2@gmail.com' }
  s.source           = { :git => 'https://github.com/aruffolo/ScalingGradientAnimatedButton.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AntonioRuffolo1'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ScalingGradientAnimatedButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ScalingGradientAnimatedButton' => ['ScalingGradientAnimatedButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
