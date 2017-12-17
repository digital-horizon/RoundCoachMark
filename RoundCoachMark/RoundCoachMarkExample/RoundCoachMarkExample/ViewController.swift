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
        coachMarker = CoachMarker(in:marksContainer)
    }

    @objc func onCoachMarkerStarted() 
    {
        coachMarker?.registerMark(position:CGPoint(x:345,y:42), aperture:20, title:"", info:"", control:nil)
        coachMarker?.registerMark(position:CGPoint(x:157,y:161), aperture:20, title:"", info:"", control:nil)
        coachMarker?.registerMark(position:CGPoint(x:276,y:637), aperture:20, title:"", info:"", control:nil)
        coachMarker?.registerMark(position:CGPoint(x:188,y:621), aperture:40, title:"", info:"", control:nil)
    }

    @IBAction func onTap(_ sender: Any) 
    {
        coachMarker?.showNextMark()
    }
    
}

