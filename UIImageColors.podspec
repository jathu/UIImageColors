Pod::Spec.new do |spec|
  spec.name        = "UIImageColors"
  spec.version     = "3.0.0"
  spec.license     = "MIT"
  spec.summary     = "iTunes style color fetcher for UIImage and NSImage."
  spec.homepage    = "https://github.com/jathu/UIImageColors"
  spec.authors     = { "Jathu Satkunarajah" => "https://twitter.com/jathu" }
  spec.source      = { :git => "https://github.com/jathu/UIImageColors.git", :tag => spec.version }

  spec.ios.deployment_target = "8.0"
  spec.tvos.deployment_target = "9.0"
  spec.macos.deployment_target = "10.10"
  spec.source_files = "UIImageColors/Sources/*.swift"
  spec.requires_arc = true
  spec.pod_target_xcconfig = {
    "SWIFT_VERSION" => "5.0"
  }
end
