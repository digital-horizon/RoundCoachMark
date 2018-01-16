
Pod::Spec.new do |s|
  s.name         = "RoundCoachMark"
  s.version      = "1.0.0"
  s.summary      = "Useful tools for round coachmarks"
  s.homepage     = "https://github.com/GPBDigital/RoundCoachMark.git"
  s.license      = 'MIT'

  s.author       = { 
    "Dima Choock" => "d.choock@gmail.com" 
  }

  s.ios.deployment_target = '10.0'
  
  s.social_media_url = 'https://gpbdigital.com/'
  s.source       = { 
    :git => "https://github.com/GPBDigital/RoundCoachMark.git", 
    :tag => s.version.to_s
  }

  s.source_files = 'RoundCoachMark/RoundCoachMark/*.{h,m,swift,plist}'
  s.requires_arc = true
  s.framework = 'UIKit'
end