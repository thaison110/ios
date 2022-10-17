# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MamNon' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'ReachabilitySwift'
  pod 'SDWebImage'
  pod 'Alamofire', '4.9.1'
  pod 'ObjectMapper'
  pod 'IQKeyboardManagerSwift'
  pod 'SVProgressHUD'
  pod 'Toast'
  pod 'FSCalendar'
  pod 'CarbonKit'
  pod 'FloatingPanel', '~>1.7.6'
  # Pods for MamNon

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
end
