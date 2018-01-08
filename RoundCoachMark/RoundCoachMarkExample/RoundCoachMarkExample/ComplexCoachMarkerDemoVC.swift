//
//  ComplexCoachMarkerDemoVC.swift
//  RoundCoachMarkExample
//
//  Created by Dima Choock on 04/01/2018.
//  Copyright © 2018 GPB DIDZHITAL. All rights reserved.
//

import UIKit
import RoundCoachMark

class ComplexCoachMarkerDemoVC: UIViewController 
{
    @IBOutlet var marksContainer: UIView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var showmodalButton: UIButton!
    
    private var coachMarker:CoachMarker?
    private var markHandlers = [CoachMarkHandler]()
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        registerMarks()
    }
    override func viewWillDisappear(_ animated: Bool) 
    {
        super.viewWillDisappear(animated)
        unregisterMarks()
    }

// MARK: - MARKER AND MARKS
    
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
    func registerMarks()
    {
        markHandlers.append(CoachMarker.registerMark(title:"Show modal view controller", info:"A modal view controller brings his owm coach marks, so other marks are to be disabled. It's done by 'unregistering' active marks in viewWillDisappear of overlapped controllers.", control:showmodalButton))
    }
    func unregisterMarks()
    {
        markHandlers.forEach 
        { handler in
            CoachMarker.unregisterMark(handler)
        }
        markHandlers.removeAll()
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
    
// MARK: - BUTTON HANDLERS
    
    @IBAction func onBack(_ sender: Any) 
    {
        navigationController!.popViewController(animated: true)
    }
    @IBAction func onReset(_ sender: Any) 
    {
        guard !showMarks else {return}
        marksCount = nil
        
        createCoachMarker()
        onTap(self)
    }
}

class TopEmbeddedVC: UIViewController 
{
    @IBOutlet weak var tstButtonContainer1: UIView!
    @IBOutlet weak var tstButtonContainer2: UIView!
    @IBOutlet weak var tstIndicator: UIActivityIndicatorView!
    
    private var markHandlers = [CoachMarkHandler]()
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        tstButtonContainer1.layer.cornerRadius = tstButtonContainer1.bounds.size.height/2
        tstButtonContainer2.layer.cornerRadius = tstButtonContainer2.bounds.size.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        registerMarks()
    }
    override func viewWillDisappear(_ animated: Bool) 
    {
        super.viewWillDisappear(animated)
        unregisterMarks()
    }
    
    func registerMarks()
    {
        markHandlers.append(CoachMarker.registerMark(title:"Home button", info:"Does nothing, added for demo purposes.", control:tstButtonContainer1))
        markHandlers.append(CoachMarker.registerMark(title:"Four squares button", info:"Can actually mean whatever you want! Thus it is very usefull in general but does nothing, added for demo purposes.", control:tstButtonContainer2))
        markHandlers.append(CoachMarker.registerMark(title:"Activity indicator", info:"Shows nothing, added for demo purposes.", control:tstIndicator))
    }
    func unregisterMarks()
    {
        markHandlers.forEach 
        { handler in
            CoachMarker.unregisterMark(handler)
        }
    }
    
}
class BotEmbeddedVC: UIViewController 
{
    @IBOutlet weak var tstSwitcher1: UISwitch!
    @IBOutlet weak var tstSwitcher2: UISwitch!
    
    private var markHandlers = [CoachMarkHandler]()
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        registerMarks()
    }
    override func viewWillDisappear(_ animated: Bool) 
    {
        super.viewWillDisappear(animated)
        unregisterMarks()
    }
    
    func registerMarks()
    {
        markHandlers.append(CoachMarker.registerMark(title:"Left switch", info:"Does nothing, what's common for lefts as you probably know, added for demo purposes.", control:tstSwitcher1))
        markHandlers.append(CoachMarker.registerMark(title:"Right switch", info:"Controls the left one, added for the sake of justice!", control:tstSwitcher2))
    }
    func unregisterMarks()
    {
        markHandlers.forEach 
        { handler in
            CoachMarker.unregisterMark(handler)
        }
    }
    @IBAction func onRightSwitch(_ sender: Any) 
    {
        tstSwitcher1.isOn = !tstSwitcher1.isOn
    }
    
}
