Pod::Spec.new do |spec|
  spec.name        = "UIImageColors"
  spec.version     = "1.3.0"
  spec.license     = "MIT"
  spec.summary     = "iTunes style color fetcher for UIImage."
  spec.homepage    = "https://github.com/jathu/UIImageColors"
  spec.authors     = { "Jathu Satkunarajah" => "https://twitter.com/jathu" }
  spec.source      = { :git => "https://github.com/jathu/UIImageColors.git", :tag => spec.version }

  spec.ios.deployment_target = "8.0"
  spec.source_files = "Sources/*.swift"
  spec.requires_arc = true
  spec.pod_target_xcconfig = {
    "SWIFT_VERSION" => "3.0"
  }
end
