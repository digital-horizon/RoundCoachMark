//
//  CoachRingView.swift
//  RoundCoachMark
//
//  Created by Dima Choock on 14/12/2017.
//  Copyright © 2017 GPB DIDZHITAL. All rights reserved.
//

import UIKit

public class CoachRingView: UIView 
{
    public var ringGeometry:CoachRing? {didSet{setNeedsDisplay()}}
    
    override public func draw(_ rect: CGRect) 
    {
        guard let ring = ringGeometry else {return}
        CoachMarkGeometry.drawCoachRing(controlRadius: ring.controlRadius, 
                                        controlCenter: ring.controlCenter, 
                                        ringRadius: ring.radius, 
                                        ringCenter: ring.center)
    }


}
