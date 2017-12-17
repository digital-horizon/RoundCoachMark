//
//  CoachMarkerUtilites.swift
//  RoundCoachMark
//
//  Created by Dima Choock on 17/12/2017.
//  Copyright © 2017 GPB DIDZHITAL. All rights reserved.
//

import Foundation

public extension UIView 
{
    func constrainFill(padding:CGPoint) 
    {
        guard superview != nil else {return}
        
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: padding.x).isActive = true
        topAnchor.constraint(equalTo: superview!.topAnchor, constant: padding.y).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: padding.x).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: padding.y).isActive = true
    }
    func constrainSize(_ size:CGSize) 
    {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    func constrainCenter(offset:CGPoint)
    {
        guard superview != nil else {return}
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor, constant: offset.x).isActive = true
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor, constant:offset.y).isActive = true
    }
}
