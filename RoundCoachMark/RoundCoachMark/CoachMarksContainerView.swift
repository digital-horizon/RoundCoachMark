//
//  CoachMarksView.swift
//  RoundCoachMark
//
//  Created by Dima Choock on 13/12/2017.
//  Copyright © 2017 GPB DIDZHITAL. All rights reserved.
//

import UIKit

public class CoachMarksContainerView: UIView 
{
    let centers:[CGPoint]
    let radiuses:[CGFloat]
    
    var ringView:CoachRingView?
    var ringIdx:Int = -1
    
//    override public init(frame: CGRect) 
//    {
//        
//        super.init(frame: frame)
//    }
    
    required public init?(coder aDecoder: NSCoder) 
    {
        centers = [
            CGPoint(x:345,y:42),
            CGPoint(x:157,y:161),
            CGPoint(x:276,y:637),
            CGPoint(x:188,y:621)
        ]
        radiuses = [
            CGFloat(20),
            CGFloat(20),
            CGFloat(20),
            CGFloat(40),
        ]
        super.init(coder: aDecoder)
    }
    
    public func showCoachMark(tmpBox:CGRect)
    {
        if let prev_ring = ringView {prev_ring.removeFromSuperview()}
        var idx:Int
        repeat
        {
            idx = Int(arc4random()%4)
        }
        while(idx == ringIdx)
        ringIdx = idx
        
        let control_center = CGPoint(x:200,y:620)
        let control_radius:CGFloat = 20
        let text_bb = tmpBox//CGRect(x:100, y:300, width:100, height:100)
        let ring = CoachRing(controlCenter:centers[ringIdx], controlRadius:radiuses[ringIdx], innerRect:text_bb, outerRect:self.bounds, excenterShift:CGPoint(x:0,y:-20), excenterRadius:nil)
        ringView = CoachRingView(frame:self.bounds)
        ringView!.ringGeometry = ring
        ringView!.backgroundColor = UIColor.clear
        self.insertSubview(ringView!, at:0)
    }

}
