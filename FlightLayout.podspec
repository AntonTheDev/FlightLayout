Pod::Spec.new do |s|
  s.name         = "FlightLayout"
  s.version      = "0.8.0"
  s.summary      = "Alternative to AutoLayout. Makes a perfect companion for FlightAnimator"
  s.homepage     = "https://github.com/AntonTheDev/FlightLayout"
  s.license      = 'MIT'
  s.author       = { "Anton Doudarev" => "antonthedev@gmail.com" }
  s.source       = { :git => 'https://github.com/AntonTheDev/FlightLayout.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = "Source/*.*"
  s.requires_arc = true
end
