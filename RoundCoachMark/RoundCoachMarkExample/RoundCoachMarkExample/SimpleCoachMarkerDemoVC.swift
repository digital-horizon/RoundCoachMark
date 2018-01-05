//
//  ViewController.swift
//  RoundCoachMarkExample
//
//  Created by Nikolay Kapustin on 12/13/17.
//  Copyright © 2017 GPB DIDZHITAL. All rights reserved.
//

import UIKit
import RoundCoachMark

class SimpleCoachMarkerDemoVC: UIViewController 
{
    @IBOutlet var marksContainer: UIView!
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var tstButton0: UIButton!
    @IBOutlet weak var tstButton1: UIButton!
    @IBOutlet weak var tstButton2: UIButton!
    
    @IBOutlet weak var tstField0: UITextField!
    @IBOutlet weak var tstField1: UITextField!
    
    private var coachMarker:CoachMarker?
    private var markHandlers = [CoachMarkHandler]()
    
// MARK: - SETUP
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupView()
    }
    
    private func setupView()
    {
        tstField0.leftView = UIImageView(image:UIImage(named: "menu-wishes"))
        tstField1.leftView = UIImageView(image:UIImage(named: "menu-support"))
        tstField0.leftViewMode = .always
        tstField1.leftViewMode = .always
    }
    
    private func createCoachMarker()
    {
        navigationController!.view.addSubview(marksContainer)
        marksContainer.constrainFill(padding:CGPoint.zero)
        navigationController!.view.layoutIfNeeded()
        
        coachMarker = CoachMarker(in:marksContainer, infoPadding:20)
        
        guard let marker = coachMarker,
            let info_view = marker.currentInfoView else {return}
        info_view.setTitleStyle(font: UIFont(name:"Verdana", size:20) ?? UIFont.systemFont(ofSize: 20), color: UIColor.white)
        info_view.setInfoStyle(font: UIFont(name:"Verdana", size:16) ?? UIFont.systemFont(ofSize: 16), color: UIColor.white)
        
        showMarks = true
    }

    private func addMarks() 
    {
        guard let controls = tstButton0.superview else {return}
        
        // There are several methods to add (or register) a mark.
        // 1. Pass no control view - control:nil - and position in marker's coordinate system:
        let pos_0 = controls.convert(tstButton0.center, to:marksContainer)
        let ape_0 = tstButton0.bounds.height + 6
        coachMarker?.addMark(title:"A fancy one, right?", info:"You think what is this? Yeah, I know it is an icon, but what does it depict? You don't know? That's why your users need HELP and the best way to help them is to use CoachMarker! By the way, the icon depicts life saving device called lifebuoy.", position:pos_0, aperture:ape_0, control:nil)
        
        // 2. Pass control view (to allow marker convert), shift from control center and aperture:
        let ape_1 = tstButton1.bounds.height + 6
        coachMarker?.addMark(title:"Stunningly!", info:"It's when you are shifting left and right fast without falling. Shaking, jiggling, you know. There also are some other words describing CoachMarker: breathtakingly, shockingly, appallingly, horribly nice.", centerShift:CGPoint.zero, aperture:ape_1, control:tstButton1)
        
        // 3. Pass control view only, to use default values for center and aperture
        coachMarker?.addMark(title:"Gear up!", info:"What are you waiting for? These icons have no meaning! I mean they can mean whatever. Each developer uses them to designate what he thinks the icons shows. CoachMarker is the only and the best method to stop the mess.", control:tstButton2)
        
        if let lead_icon = tstField0.leftView
        {
            let description = tstField0.text == "" ? "Next time before starting CoachMarker select the field and put some text in it in order to make 'clear' button visible. Visible clear button also marked."
                                                   : "Now when the field contains a text and clear button is visible, mark for this button is added too."
            coachMarker?.addMark(title:"Input field", info:description, control:lead_icon)
        }
        if tstField0.text != "" // clear button visible
        {
            // Clear button is not accessible, convert manually:
            let clear_rect = tstField0.clearButtonRect(forBounds:tstField0.bounds)
            let pos_i = tstField0.convert(CGPoint(x:clear_rect.midX,y:clear_rect.midY), to:marksContainer)
            let ape_i = clear_rect.size.width + 6
            
            coachMarker?.addMark(title:"Field's clear button", info:"The field contains a text and clear button is visible. Tap it and next time this mark won't be shown!", position:pos_i, aperture:ape_i, control:nil)
        }
        
        if let lead_icon = tstField1.leftView
        {
            let description = tstField1.text == "" ? "Next time before starting CoachMarker select this field also and input some text in order to make 'clear' button visible."
                                                   : "Now when the field contains a text and clear button is visible, mark for this button is added too."
            coachMarker?.addMark(title:"Another Input field", info:description, control:lead_icon)
        }
        if tstField1.text != "" // clear button visible
        {
            let clear_rect = tstField1.clearButtonRect(forBounds:tstField1.bounds)
            let pos_i = tstField1.convert(CGPoint(x:clear_rect.midX,y:clear_rect.midY), to:marksContainer)
            let ape_i = clear_rect.size.width + 6
            coachMarker?.addMark(title:"Field's clear button", info:"The field contains a text and clear button is visible. Tap it and next time this mark won't be shown!", position:pos_i, aperture:ape_i, control:nil)
        }

        coachMarker?.addMark(title:"HELP is better than dosens of fancy icons!", info:"Use HELP button to restart this simple CoachMarker demo. Once started CoachMarker will show all added marks one after another, but it's not its inate behavior. You control what to show from outside code.", control:helpButton)
    }

// MARK: - SHOW MARKS
    
    private var marksCount:Int?
    private var showMarks:Bool = false
    
    @IBAction func onTap(_ sender: Any) 
    {
        guard showMarks else {return}
        if marksCount == nil {marksCount = coachMarker?.marksCount}
        if marksCount! == 0
        {
            coachMarker?.destroy 
            {
                self.marksContainer.removeFromSuperview()
                self.markHandlers.removeAll()
            }
            showMarks = false
        }
        else
        {
            coachMarker?.presentNextMark
            { [weak self] in
                self?.marksCount! -= 1
            }
        }
    }

// MARK: - HANDLERS
    
    @IBAction func onReset(_ sender: Any) 
    {
        guard !showMarks else {return}
        view.layoutIfNeeded()
        createCoachMarker()
        addMarks()
        marksCount = nil
        onTap(self)
    }
    
}

extension UIView 
{
    func constrainFill(padding:CGPoint) 
    {
        guard superview != nil else {return}
        
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: padding.x).isActive = true
        topAnchor.constraint(equalTo: superview!.topAnchor, constant: padding.y).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: padding.x).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: padding.y).isActive = true
        layoutIfNeeded()
    }
}

