//
//  CoachMarksView.swift
//  RoundCoachMark
//
//  Created by Dima Choock on 13/12/2017.
//  Copyright © 2017 GPB DIDZHITAL. All rights reserved.
//

import UIKit

class CoachMarksCanvas: UIView 
{
    var ringView:CoachRingView?
    
    var markInfo:CoachMarkInfoView?
    {
        didSet
        {
            addSubview(markInfo as! UIView)
            (markInfo as! UIView).constrainSize(markInfo?.viewSize ?? CGSize(width:100,height:100))
            (markInfo as! UIView).constrainCenter(offset:markInfo?.centerOffset ?? CGPoint.zero)
            (markInfo as! UIView).alpha = 0
        }
    }
    
// MARK: - CONTROL INTERFACE
    
    func replaceCurrentMark(with mark:CoachMarker.MarkInfo)
    {
        if let ring = ringView
        {
            ring.openRing(false,
            completion:
            { [weak self] in
                ring.removeFromSuperview()
                self?.show(mark)
            })
            ringView = nil
            (markInfo as! UIView).alpha = 0
            return
        }
        show(mark)
    }
    func show(_ mark:CoachMarker.MarkInfo)
    {
        // TODO: replace info view if required by MarkInfo
        let text_bb = (markInfo as! UIView).frame
        (markInfo as! UIView).alpha = 0
        let ring = CoachRing(controlCenter:mark.position, controlRadius:mark.aperture, innerRect:text_bb, outerRect:self.bounds)//, excenterShift:CGPoint(x:0,y:-20), excenterRadius:nil)
        ringView = CoachRingView(frame:self.bounds)
        ringView!.ringGeometry = ring
        ringView!.backgroundColor = UIColor.clear
        insertSubview(ringView!, at:0)
        ringView?.openRing(true,completion:{(self.markInfo as! UIView).alpha = 1})
    }
    
    func removeCurrentMark(completion:@escaping ()->Void)
    {
        if let ring = ringView
        {
            ring.openRing(false,
            completion:
            { 
                ring.removeFromSuperview()
                completion()
            })
            ringView = nil
            (markInfo as! UIView).alpha = 0
        }
    }
    
// MARK: - INIT
    
    required init?(coder aDecoder: NSCoder) 
    {
        super.init(coder: aDecoder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
