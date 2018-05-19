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
    core.dependency 'RxCocoa'
  end

  s.subspec 'MBProgressHUD' do |ss|
    ss.source_files = 'iOSKit/MBProgressHUD/**/*.swift'
    ss.dependency 'MBProgressHUD'
    ss.resource_bundle = { 'mbp' => 'iOSKit/MBP/MBP.xcassets' }
  end

  s.subspec 'SVProgressHUD' do |ss|
    ss.source_files = 'iOSKit/SVProgressHUD/**/*'
    ss.dependency 'SVProgressHUD'
  end

  s.subspec 'NVActivityIndicatorView' do |ss|
    ss.source_files = 'iOSKit/NVActivityIndicatorView/**/*'
    ss.dependency 'NVActivityIndicatorView'
  end

  s.subspec 'ObjectiveC' do |ss|
    ss.source_files = 'iOSKit/ObjectiveC/**/*'
  end

  s.subspec 'SwiftyJSON' do |ss|
    ss.source_files = 'iOSKit/SwiftyJSON/**/*'
    ss.dependency 'SwiftyJSON'
  end

  s.subspec 'RxSwift' do |ss|
    ss.source_files = 'iOSKit/RxSwift/**/*'
    ss.dependency 'RxSwift'
  end

  s.subspec 'All' do |ss|
    ss.dependency 'iOSKit/Core'
    ss.dependency 'iOSKit/MBProgressHUD'
    ss.dependency 'iOSKit/SVProgressHUD'
    ss.dependency 'iOSKit/NVActivityIndicatorView'
    ss.dependency 'iOSKit/RxSwift'
    ss.dependency 'iOSKit/SwiftyJSON'
    ss.dependency 'iOSKit/ObjectiveC'
  end

end
