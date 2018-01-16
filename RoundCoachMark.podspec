
Pod::Spec.new do |s|
  s.name         = "RoundCoachMark"
  s.version      = "1.0.0"
  s.summary      = "Useful tools for round coachmarks"
  s.homepage     = "https://gpbdigital.com/"
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

  s.source_files = '*.{h,m,swift}'
  s.requires_arc = true
  s.framework = 'UIKit'
end