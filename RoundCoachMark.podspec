
Pod::Spec.new do |s|
  s.name         = "RoundCoachMark"
  s.version      = "1.0.3"
  s.summary      = "Useful tools for round coachmarks"
  s.homepage     = "https://github.com/digital-horizon/RoundCoachMark"
  s.license      = 'MIT'
  s.swift_versions = '4.2'

  s.author       = { 
    "Dima Choock" => "d.choock@gmail.com" 
  }

  s.ios.deployment_target = '10.3'
  
  s.social_media_url = 'https://digitalhorizon.ru'
  s.source       = { 
    :git => "https://github.com/digital-horizon/RoundCoachMark.git", 
    :tag => s.version.to_s
  }

  s.source_files = 'RoundCoachMark/RoundCoachMark/*.{h,m,swift,plist}'
  s.requires_arc = true
  s.framework = 'UIKit'
end
