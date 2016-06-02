Pod::Spec.new do |s|
  s.name         = "SwiftLayout"
  s.version      = "0.1.0"
  s.summary      = "An alternative layout framework that does not rely on AutoLayout"
  s.homepage     = "https://github.com/AntonTheDev/SwiftLayout"
  s.license      = 'MIT'
  s.author       = { "Anton Doudarev" => "antonthedev@gmail.com" }
  s.source       = { :git => 'https://github.com/AntonTheDev/SwiftLayout.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.source_files = "Source/*.*"
  s.requires_arc = true
end
