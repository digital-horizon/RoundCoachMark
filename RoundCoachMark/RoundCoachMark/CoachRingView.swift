//
//  CoachRingView.swift
//  RoundCoachMark
//
//  Created by Dima Choock on 14/12/2017.
//  Copyright © 2017 GPB DIDZHITAL. All rights reserved.
//

import UIKit

class CoachRingView: UIView, CAAnimationDelegate
{
    public var ringGeometry:CoachRing?
    //public var open:Bool = false {didSet{openRing(open)}}
    
    private var completionBlock:()->Void = {}
    
    override class var layerClass : AnyClass
    {
        return CMRingLayer.self
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) 
    {
        if (anim as? CABasicAnimation)?.keyPath == "ringRadius"
        {
            completionBlock()
        }
    }
    
    public func openRing(_ open:Bool, completion:@escaping ()->Void)
    {
        guard let ring = ringGeometry else {return}
        completionBlock = completion
        let timing: CAMediaTimingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        let duration = 0.3
        let end_radius = open ? ring.radius : ring.controlRadius
        let beg_radius = open ? ring.controlRadius : ring.radius
        
        let opening = CABasicAnimation(keyPath: "ringRadius")
        opening.duration = duration
        opening.fillMode = kCAFillModeBoth
        opening.timingFunction = timing
        opening.fromValue = beg_radius
        opening.toValue = end_radius
        opening.delegate = self
        layer.add(opening, forKey:"ring")
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        (layer as! CMRingLayer).ringRadius = end_radius
        CATransaction.commit()
        
        guard open
        else
        {
            layer.removeAnimation(forKey:"pulse")
            return
        }
        
        let pulse = CABasicAnimation(keyPath: "controlRadius")
        pulse.duration = duration
        pulse.autoreverses = true
        pulse.repeatCount = Float.infinity
        pulse.fillMode = kCAFillModeBoth
        pulse.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        pulse.fromValue = beg_radius
        pulse.toValue = beg_radius + 10
        layer.add(pulse, forKey:"pulse")
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        (layer as! CMRingLayer).controlRadius = beg_radius + 10
        CATransaction.commit()
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext)
    {
        guard let ring = ringGeometry else {return}
        let ring_radius = (layer as! CMRingLayer).ringRadius
        let control_radius = (layer as! CMRingLayer).controlRadius
        UIGraphicsPushContext(ctx)
        CoachMarkGeometry.drawCoachRing(controlRadius: control_radius, 
                                        controlCenter: ring.controlCenter, 
                                        ringRadius: ring_radius, 
                                        ringCenter: ring.center)
        UIGraphicsPopContext()
    }

        

}

class CMRingLayer: CALayer
{
    @NSManaged var ringRadius: CGFloat
    @NSManaged var controlRadius: CGFloat
    
    override class func needsDisplay(forKey key: (String!)) -> Bool
    {
        if key == "ringRadius" || key == "controlRadius" {return true}
        else                   {return super.needsDisplay(forKey: key)}
    }
    
    override func action(forKey event: (String!)) -> (CAAction!)
    {
        if event == "ringRadius" || event == "controlRadius" 
        {
            let animation = CABasicAnimation.init(keyPath:event)
            animation.fromValue = presentation()?.value(forKey: event)
            return animation
        }
        return super.action(forKey: event)
    }
    
// MARK: - CONSTRUCTORS
    
    override init()
    {
        super.init()
        ringRadius = 0.0
        controlRadius = 0.0
    }
    override init(layer: Any)
    {
        super.init(layer: layer)
        if let layer = layer as? CMRingLayer 
        {
            ringRadius = layer.ringRadius
            controlRadius = layer.controlRadius
        }
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
