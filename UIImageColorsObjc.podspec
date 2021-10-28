Pod::Spec.new do |spec|
  spec.name = "UIImageColorsObjc"
  spec.version = "3.0.0"
  spec.license = "MIT"
  spec.summary = "iTunes style color fetcher for UIImage and NSImage."
  spec.homepage = "https://github.com/jathu/UIImageColors"
  spec.authors = "Jathu Satkunarajah", "Felix Herrmann"
  spec.source = {
    :git => "https://github.com/jathu/UIImageColors.git",
    :tag => spec.version
  }
  
  spec.ios.deployment_target = "9.0"
  spec.tvos.deployment_target = "9.0"
  spec.watchos.deployment_target = "2.0"
  spec.macos.deployment_target = "10.10"
  spec.requires_arc = true
  spec.swift_version = "5.5"
  
  spec.source_files = "Sources/**/*"
end
