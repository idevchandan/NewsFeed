# Uncomment the next line to define a global platform for your project
# platform :ios, '14.0'

target 'NewsFeed' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'ReactiveObjC'
  pod 'Masonry'

  target 'NewsFeedTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NewsFeedUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "14.0"
    end
  end
end
