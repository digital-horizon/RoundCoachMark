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
    @IBOutlet weak var marksView: CoachMarksContainerView!
    @IBOutlet weak var tempTextBox: UIView!
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        marksView.isHidden = true
    }

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) 
    {
        marksView.isHidden = false
        tempTextBox.alpha = 0
        marksView.showCoachMark(tmpBox:tempTextBox)
    }
    
}

