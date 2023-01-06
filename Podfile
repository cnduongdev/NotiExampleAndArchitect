# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def myPods
  pod 'FirebaseCrashlytics'
  pod 'Firebase/Analytics'

  # Add the pod for Firebase Cloud Messaging
  pod 'FirebaseMessaging'
  pod 'FirebaseDynamicLinks'
end

target 'NotiExample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NotiExample
  myPods	
  target 'NotiExampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NotiExampleUITests' do
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # https://github.com/CocoaPods/CocoaPods/issues/9884
  #    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
  end
end
