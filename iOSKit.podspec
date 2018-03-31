Pod::Spec.new do |s|
  #
  # Pod Basic Info
  #

  s.name             = 'iOSKit'
  s.version          = '0.1.0'
  s.summary          = 'My iOS extension library'

  s.description      = <<-DESC
  My iOS app development toolbox
  DESC

  #
  # Author Info
  #

  s.homepage         = 'https://github.com/mudox/ios-kit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Mudox'
  s.source           = { :git => 'https://github.com/mudox/ios-kit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  #
  # Pod Payload
  #

  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = 'iOSKit/Core/**/*'

    core.dependency 'JacKit'
    core.dependency 'RxSwift'
  end

  s.subspec 'MBP' do |ss|
    ss.source_files = 'iOSKit/MBProgressHUD/MPB.swift'
    ss.dependency 'MBProgressHUD', '~> 1.0'
  end

  s.subspec 'SVP' do |ss|
  ss.source_files = 'iOSKit/SVProgressHUD/**/*'
  ss.dependency 'SVProgressHUD'
  end

  s.subspec 'SwiftyJSON' do |ss|
    ss.source_files = 'iOSKit/SwiftyJSON/**/*'
    ss.dependency 'SwiftyJSON'
  end

end
