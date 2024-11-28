Pod::Spec.new do |s|
  s.name             = 'LGMindKit'
  s.version          = '0.1.0'
  s.summary          = 'Your SDK short description.'
  s.description      = 'A longer description of your SDK.'
  s.homepage         = 'https://github.com/ChenYingYing1989/LGMindKit'
  s.license          = { :type => 'MIT', :text => 'LICENSE' }
  s.authors          = { 'BonnieChen' => '861488970@qq.com' }
  s.source           = { :git => 'https://github.com/ChenYingYing1989/LGMindKit.git', :tag => s.version }
  s.source_files     = 'LGMindKit/Classes/**/*.{h,m}'
  
  # 确保资源文件路径正确
  s.resources = 'LGMindKit/Assets.xcassets/**/*'
  
  s.platform         = :ios, '12.0'
  #s.ios.deployment_target = '12.0'
  #s.build_settings = { 'IPHONEOS_DEPLOYMENT_TARGET' => '12.0' }
  #s.requires_arc     = true
  
  
  
  # 如果有依赖的第三方库
  s.dependency       'FDFullscreenPopGesture','~>1.1'
  s.dependency       'SDCycleScrollView' , '~>1.82'
  s.dependency       'IQKeyboardManager' , '~>6.5.19'
  s.dependency       'WMPageController' , '~>2.5.2'
  s.dependency       'AFNetworking' , '~>4.0.1'
  s.dependency       'MJExtension' , '~>3.4.2'
  s.dependency       'SDWebImage' , '~>5.20.0'
  s.dependency       'MJRefresh' , '~>3.7.9'
  s.dependency       'Masonry' , '~>1.1.0'
  
end

