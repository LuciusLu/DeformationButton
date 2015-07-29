#DeformationButton.podspec
Pod::Spec.new do |s|
  s.name         = "DeformationButton"
  s.version      = "1.0"
  s.summary      = "Share loading button"

  s.homepage     = "https://github.com/LuciusLu/DeformationButton"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "LuciusLu" => "luckysixdays@gmail.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/LuciusLu/DeformationButton.git", :tag => "v#{s.version}" }
  s.source_files  = 'DeformationButton/DeformationButton/MMMaterialDesignSpinner-master/*.{h,m}' , 'DeformationButton/DeformationButton/*.{h,m}'
  s.requires_arc = true
  s.frameworks = 'Foundation', 'UIKit'
end