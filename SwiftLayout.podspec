Pod::Spec.new do |s|
  s.name         = "SwiftLayout"
  s.version      = "0.7.0"
  s.summary      = "Alternative to AutoLayout. Makes a perfect companion for FlightAnimator"
  s.homepage     = "https://github.com/AntonTheDev/SwiftLayout"
  s.license      = 'MIT'
  s.author       = { "Anton Doudarev" => "antonthedev@gmail.com" }
  s.source       = { :git => 'https://github.com/AntonTheDev/SwiftLayout.git', :tag => s.version }
  s.ios.deployment_target = '9.0'
  s.source_files = "Source/*.*"
  s.requires_arc = true
end
