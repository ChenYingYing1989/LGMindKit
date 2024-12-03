Pod::Spec.new do |s|
  s.name             = 'LGMindKit'
  s.version          = '0.1.0'
  s.platform     = :ios
  s.ios.deployment_target = '12.0'
  s.summary          = 'Your SDK short description.'
  s.description      = 'A longer description of your SDK.'
  s.homepage         = 'https://github.com/ChenYingYing1989/LGMindKit'
  s.license          = { :type => 'MIT', :text => 'LICENSE' }
  s.authors          = { 'BonnieChen' => '861488970@qq.com' }
  s.source           = { :git => 'https://github.com/ChenYingYing1989/LGMindKit.git', :tag => s.version }
  s.source_files     = 'Classes/**/*.{h,m}'
  # 确保资源文件路径正确
  s.resources = 'Classes/Assets.xcassets/**/*'
  
  s.xcconfig = {'VALID_ARCHS' => 'x86_64 armv7 arm64',}

  s.requires_arc     = true
  
  
  
  # 如果有依赖的第三方库
    #s.dependency       'FDFullscreenPopGesture'
    #s.dependency       'SDCycleScrollView'
    #s.dependency       'IQKeyboardManager'
    #s.dependency       'WMPageController'
    #s.dependency       'MBProgressHUD'
    #s.dependency       'AFNetworking'
    #s.dependency       'SDWebImage'
  #s.dependency       'Masonry'
  
end

#验证
# pod lib lint --verbose --no-clean
