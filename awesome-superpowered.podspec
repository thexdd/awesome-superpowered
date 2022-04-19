require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "awesome-superpowered"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/thexdd/awesome-superpowered.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift}"
#, "Superpowered/**/*.{h,cpp}"

  s.exclude_files = [
    "Superpowered/libSuperpoweredAndroidarm64-v8a.a",
    "Superpowered/libSuperpoweredAndroidarmeabi-v7a.a",
    "Superpowered/libSuperpoweredAndroidX86_64.a",
    "Superpowered/libSuperpoweredAndroidX86.a",
    "Superpowered/OpenSource/SuperpoweredAndroidAudioIO.cpp",
    "Superpowered/OpenSource/SuperpoweredAndroidAudioIO.h",
  ]

  s.dependency "React-Core"
end