//
//  ComplexCoachMarkerDemoVC.swift
//  RoundCoachMarkExample
//
//  Created by Dima Choock on 04/01/2018.
//  Copyright © 2018 GPB DIDZHITAL. All rights reserved.
//

import UIKit

class ComplexCoachMarkerDemoVC: UIViewController 
{

    override func viewDidLoad() 
    {
        super.viewDidLoad()
    }
    
//    func registerMarks()
//    {
//        markHandlers.append(CoachMarker.registerMark(position:CGPoint(x:345,y:42), aperture:20, title:"Mark:345,42 long looong very long and useles label", info:"Some wordy description. Some wordy description. Some wordy description. Some wordy description.", control:nil))
//        markHandlers.append(CoachMarker.registerMark(position:CGPoint(x:157,y:161), aperture:20, title:"Mark:157,161", info:"Some wordy description. Some wordy description. Some wordy description. Some wordy description.", control:nil))
//        markHandlers.append(CoachMarker.registerMark(position:CGPoint(x:276,y:637), aperture:20, title:"Mark:276,637", info:"Some wordy description. Some wordy description. Some wordy description. Some wordy description.", control:nil))
//        markHandlers.append(CoachMarker.registerMark(position:CGPoint(x:188,y:621), aperture:40, title:"Mark:188,621", info:"Some wordy description. Some wordy description. Some wordy description. Some wordy description.", control:nil))
//    }

    @IBAction func onBack(_ sender: Any) 
    {
        navigationController!.popViewController(animated: true)
    }
}
