# Podspec for HKNSLayoutConstraint
#   Created by Harrison Kong on 2020/02/04

Pod::Spec.new do |s|

  platform                = :ios
  s.ios.deployment_target = '8.0'

  s.name          = 'HKNSLayoutConstraint'
  s.summary       = 'HK Enhanced NSLayoutConstraint'
  s.requires_arc  = true
  s.version       = '1.0.0'
  s.license       = { :type => 'MIT' }
  s.author        = { 'Harrison Kong' => 'harrisonkong@skyroute66.com' }
  s.homepage      = 'https://github.com/harrisonkong/HKNSLayoutConstraint'
  s.source        = { :git => 'https://github.com/harrisonkong/HKNSLayoutConstraint.git',
                      :tag => '1.0.0' }
  s.dependency      'HKDeviceUtilities', '~> 1.0.0'
  s.dependency      'HKUIViewLengthCalculationBasis', '~> 1.0.0'
  s.framework     = 'UIKit'
  s.source_files  = 'HKNSLayoutConstraint/**/*.swift'
  s.swift_version = '4.2'

end
