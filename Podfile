# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'LGMindKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LGMindKit
    pod 'FDFullscreenPopGesture'
    pod 'SDCycleScrollView'
    pod 'IQKeyboardManager'
    pod 'WMPageController'
    pod 'MBProgressHUD'
    pod 'AFNetworking'
    pod 'MJExtension'
    pod 'SDWebImage'
    pod 'MJRefresh'
    pod 'Masonry'
    
 end

#Pods config
#Fix Xcode14 Bundle target error
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
