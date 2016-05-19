Pod::Spec.new do |s|
  s.name        = "UIImageColors"
  s.version     = "1.0.4"
  s.summary     = "iTunes 11 style color fetcher for UIImage"
  s.homepage    = "https://github.com/jathu/UIImageColors"
  s.authors     = { "Jathu Satkunarajah" => "https://twitter.com/jathu" }
  s.source   = { :git => "https://github.com/jathu/UIImageColors.git", :tag => s.version }

  s.ios.deployment_target = "8.0"

  s.source_files = "*.swift"

  s.requires_arc = true
end
