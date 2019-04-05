Pod::Spec.new do |s|
  s.name = "ShopGun-GenericGeometry"
  s.module_name = "GenericGeometry"
  s.version = "0.2.0"
  s.summary = "📐 A library for defining geometry of generic dimensions"

  s.description = <<-DESC
  Did you ever need to make a CGSize that didn't contain CGFloats? What about a Point of enum values? Edges where some values are optional? All this, and more, is possible with GenericGeometry.
  DESC

  s.homepage = "https://github.com/shopgun/swift-generic-geometry"

  s.license = "MIT"

  s.authors = {
    "Laurie Hufford" => "lh@shopgun.com"
  }
  s.social_media_url = "https://twitter.com/shopgun"

  s.source = {
    :git => "https://github.com/shopgun/swift-generic-geometry.git",
    :tag => s.version
  }

  s.swift_version = "5.0"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"

  s.source_files = "Sources", "Sources/**/*.swift"
end
