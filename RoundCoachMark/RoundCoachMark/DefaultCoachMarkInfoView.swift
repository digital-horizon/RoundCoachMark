//
//  DefaultCoachMarkInfoView.swift
//  RoundCoachMark
//
//  Created by Dima Choock on 17/12/2017.
//  Copyright © 2017 GPB DIDZHITAL. All rights reserved.
//

import UIKit

class DefaultCoachMarkInfoView: UIView, CoachMarkInfoView 
{
    var titleLabel:UILabel?
    var infoText:UITextView?
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
    }
    required init?(coder aDecoder: NSCoder) 
    {
        super.init(coder: aDecoder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    var viewSize:CGSize      
    {
//        guard let title = titleLabel,
//              let text = infoText else {return CGSize.zero}
        // TODO: calculate size
        return CGSize(width: 300, height: 200)
    }
    var centerOffset:CGPoint
    {
        return CGPoint.zero
    }
    
    func setTextInfo(title:String, info:String)
    {
        titleLabel?.text = title
        infoText?.text = info
    }
    func setInfo(_ info:Any){}
}
