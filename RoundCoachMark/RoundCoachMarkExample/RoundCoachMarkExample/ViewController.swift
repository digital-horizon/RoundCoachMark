//
//  ViewController.swift
//  RoundCoachMarkExample
//
//  Created by Nikolay Kapustin on 12/13/17.
//  Copyright © 2017 GPB DIDZHITAL. All rights reserved.
//

import UIKit
import RoundCoachMark

class ViewController: UIViewController 
{
    @IBOutlet weak var marksContainer: UIView!
    
    private var coachMarker:CoachMarker?
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector:#selector(onCoachMarkerStarted), name:CoachMarker.Events.CoachMarkerMarksRequest, object: nil)
        coachMarker = CoachMarker(in:marksContainer, infoPadding:20)
        guard let marker = coachMarker,
              let info_view = marker.getCurrentInfoView() else {return}
        info_view.setTitleStyle(font: UIFont(name:"Verdana", size:20) ?? UIFont.systemFont(ofSize: 20), color: UIColor.white)
        info_view.setInfoStyle(font: UIFont(name:"Verdana", size:16) ?? UIFont.systemFont(ofSize: 16), color: UIColor.white)
    }

    @objc func onCoachMarkerStarted() 
    {
        coachMarker?.registerMark(position:CGPoint(x:345,y:42), aperture:20, title:"Mark:345,42 long looong very long and useles label", info:"Some wordy description. Some wordy description. Some wordy description. Some wordy description.", control:nil)
        coachMarker?.registerMark(position:CGPoint(x:157,y:161), aperture:20, title:"Mark:157,161", info:"Some wordy description. Some wordy description. Some wordy description. Some wordy description.", control:nil)
        coachMarker?.registerMark(position:CGPoint(x:276,y:637), aperture:20, title:"Mark:276,637", info:"Some wordy description. Some wordy description. Some wordy description. Some wordy description.", control:nil)
        coachMarker?.registerMark(position:CGPoint(x:188,y:621), aperture:40, title:"Mark:188,621", info:"Some wordy description. Some wordy description. Some wordy description. Some wordy description.", control:nil)
    }

    @IBAction func onTap(_ sender: Any) 
    {
        coachMarker?.showNextMark()
    }
    
}

