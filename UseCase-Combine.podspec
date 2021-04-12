Pod::Spec.new do |s|
    s.platform = :ios
    s.ios.deployment_target = '13.0'
    s.name = "UseCase-Combine"
    s.summary = "UseCase realization based on state machine"
    s.requires_arc = true
    s.version = "1.0.0"
    s.license = { :type => "MIT", :file => "LICENSE" }
    s.author = { "Pavel Kochenda" => "peeoner174@gmail.com" }
    s.homepage = "https://github.com/Peeoner174/UseCase-Combine"
    s.source = { :git => "https://github.com/Peeoner174/UseCase-Combine.git",
    :tag => "#{s.version}" }
    s.framework = "Combine"
    s.source_files = "UseCase-Combine/**/*.{swift}"
    s.resources = "UseCase-Combine/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
    s.swift_version = "5.0"
end
