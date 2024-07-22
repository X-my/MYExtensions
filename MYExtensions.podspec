Pod::Spec.new do |s|
  s.name             = 'MYExtensions'
  s.version          = '0.0.1'
  s.summary          = 'MYExtensions'
  s.description      = 'MYExtensions'
  s.homepage         = 'https://github.com/X-my/MYExtensions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xumengyang' => 'woshixmy@163.com' }
  s.source           = { :http => 'https://github.com/X-my/MYExtensions.git' }
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0.0'
  s.source_files = 'Source/**/*.swift'
  
  s.dependency 'SwifterSwift'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'NSObject+Rx'
  s.dependency 'RxGesture'
end
 
