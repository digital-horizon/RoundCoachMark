//
//  CoachMarker.swift
//  RoundCoachMark
//
//  Created by Dima Choock on 17/12/2017.
//  Copyright © 2017 GPB DIDZHITAL. All rights reserved.
//

import UIKit

public class CoachMarker
{
    public struct MarkInfo
    {
        let position:CGPoint
        let aperture:CGFloat
        let control:Any?
        let textInfo:(String,String)?
        let info:Any?
        let infoView:CoachMarkInfoView?
    }
    
// MARK: - INIT
    
    public init(in container:UIView, infoPadding:CGFloat) 
    {
        marksContainer = container
        marksCanvas = CoachMarksCanvas(frame:container.bounds)
        marksCanvas.markInfo = DefaultCoachMarkInfoView(width:container.bounds.size.width - 2*infoPadding)
        setup()
    }
    public init(in container:UIView, infoView:CoachMarkInfoView) 
    {
        marksContainer = container
        marksCanvas = CoachMarksCanvas(frame:container.bounds)
        marksCanvas.markInfo = infoView
        setup()
    }
    private func setup()
    {
        guard let the_container = marksContainer else {return}
        the_container.addSubview(marksCanvas)
        marksCanvas.constrainFill(padding: CGPoint.zero)
        the_container.layoutIfNeeded()
        NotificationCenter.default.post(name:Events.CoachMarkerMarksRequest, object:self)
    }
    deinit 
    {
        destroy(completion:{})
    }
    
// MARK: - MARKS BLIND REGISTRATION INTERFACE
    
/// Use static registration methods below to add marks when CoachMarker not accessible abd presumably not exists. 
/// For example on viewDidLoad, viewWillAppear or on awakeFromNib of a controller or a control presenting the mark.
/// Use unregister method to prevent showing a mark for hidden or inactive controller, call it on viewWillDisappear for example.
/// Returned CoachMarkHandler has to be stored as long as the mark needs to be shown after each CoachMarker restart 
/// Discarding the handler (by hander = nil for example) works as the unregisterMark.
/// These methods are preferable for coach mark adding.
/// See <ref to example project> for usage examples
    
    @discardableResult static public func registerMark(position:CGPoint, aperture:CGFloat, title:String, info:String, control:Any? = nil, autorelease:Bool = true) ->CoachMarkHandler
    {
        let handler = CoachMarkHandler()
        handler.token = NotificationCenter.default.addObserver(forName:Events.CoachMarkerMarksRequest, object:nil, queue:OperationQueue.main)
        { note in
            guard let marker = note.object as? CoachMarker else {return}
            marker.addMark(title:title, info:info, position:position, aperture:aperture, control:control)
            if autorelease {marker.handlers.append(handler)}
        }
        return handler
    }
    @discardableResult static public func registerMark(title:String, info:String, centerShift:CGPoint = CGPoint.zero, aperture:CGFloat = 0, control:UIView, autorelease:Bool = true) ->CoachMarkHandler
    {
        let handler = CoachMarkHandler()
        handler.token = NotificationCenter.default.addObserver(forName:Events.CoachMarkerMarksRequest, object:nil, queue:OperationQueue.main)
        { note in
            guard let marker = note.object as? CoachMarker else {return}
            marker.addMark(title:title, info:info, centerShift:centerShift, aperture:aperture, control:control)
            if autorelease {marker.handlers.append(handler)}
        }
        return handler
    }
    
    @discardableResult static public func registerMark(position:CGPoint, aperture:CGFloat, info:Any, control:Any? = nil, autorelease:Bool = true) ->CoachMarkHandler
    {
        let handler = CoachMarkHandler()
        handler.token = NotificationCenter.default.addObserver(forName:Events.CoachMarkerMarksRequest, object:nil, queue:OperationQueue.main)
        { note in
            guard let marker = note.object as? CoachMarker else {return}
            marker.addMark(position:position, aperture:aperture, info:info, control:control)
            if autorelease {marker.handlers.append(handler)}
        }
        return handler
    }
    @discardableResult static public func registerMark(position:CGPoint, aperture:CGFloat, info:Any?, infoView:CoachMarkInfoView, control:Any? = nil, autorelease:Bool = true) ->CoachMarkHandler
    {
        let handler = CoachMarkHandler()
        handler.token = NotificationCenter.default.addObserver(forName:Events.CoachMarkerMarksRequest, object:nil, queue:OperationQueue.main)
        { note in
            guard let marker = note.object as? CoachMarker else {return}
            marker.addMark(position:position, aperture:aperture, info:info, infoView:infoView, control:control)
            if autorelease {marker.handlers.append(handler)}
        }
        return handler
    }
    static public func unregisterMark(_ handler:CoachMarkHandler)
    {
        NotificationCenter.default.removeObserver(handler.token)
    }
    
// MARK: - MARKS DIRECT REGISTRATION INTERFACE
    
/// Use direct adding methods below to add marks in simple situations when the marks and the CoachMarker are defined
/// in a common context of the same view controller for example.
/// See <ref to example project> for usage examples
    
    public func addMark(title:String, info:String, position:CGPoint, aperture:CGFloat, control:Any? = nil)
    {
        let mark = MarkInfo(position:position, aperture:aperture, control:control, textInfo:(title,info), info:nil, infoView:nil)
        marks.append(mark)
    }
    public func addMark(title:String, info:String, centerShift:CGPoint = CGPoint.zero, aperture:CGFloat = 0, control:UIView)
    {
        guard let control_superview = control.superview else 
        {
            print("The control's view is not in hierarchy. The mark cannot be aded")
            return 
        }
        let position = marksCanvas.convert(control.center, from:control_superview).applying(CGAffineTransform.identity.translatedBy(x: centerShift.x, y: centerShift.y))
        let the_aperture = aperture > 0 ? aperture : max(control.bounds.size.width, control.bounds.size.height) + 6
        let mark = MarkInfo(position:position, aperture:the_aperture, control:control, textInfo:(title,info), info:nil, infoView:nil)
        marks.append(mark)
    }

    
    
    public func addMark(position:CGPoint, aperture:CGFloat, info:Any, control:Any? = nil)
    {
        let mark = MarkInfo(position:position, aperture:aperture, control:control, textInfo:nil, info:info, infoView:nil)
        marks.append(mark)
    }
    
    public func addMark(position:CGPoint, aperture:CGFloat, info:Any?, infoView:CoachMarkInfoView, control:Any? = nil)
    {
        let mark = MarkInfo(position:position, aperture:aperture, control:control, textInfo:nil, info:info, infoView:infoView)
        marks.append(mark)
    }
    
// MARK: - CONTROL AND ACCESS INTERFACE
    
/// presentMark - shows the mark at the given index
/// dismissMark - hides currently shown mark
/// presentNextMark - cycle hiding/showing marks starting from the mark at 0
/// resetMarks - hides current mars, removes all added marks, re-adds marks registered with static registration methods
/// destroy - completely destruct the marker and removes it from view hierarchy, use destroy if something needs
/// to be done right after the marker removed. Discarding a marker (by marker = nil for example) performs destroy with
/// empty completion block
    
    public func presentMark(_ index:Int, completion:@escaping ()->Void)
    {
        guard marks.count > 0 else {return}
        guard let mark = mark(index) else {return}
        marksCanvas.replaceCurrentMark(with:mark, completion:completion)
    }
    public func dismissMark(completion:@escaping ()->Void)
    {
        marksCanvas.removeCurrentMark(completion:completion)
    }
    public func presentNextMark(completion:@escaping ()->Void)
    {
        guard marks.count > 0 else {return}
        presentMark(nextMarkIndex,completion:completion)
        nextMarkIndex = (nextMarkIndex+1)%marks.count
    }
    public func resetMarks(completion:@escaping ()->Void)
    {
        dismissMark(completion:completion)
        marks.removeAll()
        nextMarkIndex = 0
        DispatchQueue.main.async(execute:{NotificationCenter.default.post(name:Events.CoachMarkerMarksRequest, object:self)})
    }
    public func destroy(completion:@escaping ()->Void)
    {
        // Automatic un-registration staticaly registered marks, which handlers are not stored externally
        handlers.forEach 
        { handler in
            NotificationCenter.default.removeObserver(handler.token)
        }
        handlers.removeAll()
        // Clean up canvas
        marksCanvas.removeCurrentMark
        {
            self.marksCanvas.removeFromSuperview()
            self.marks.removeAll()
            completion()
        }
    }
    
    public var currentInfoView:CoachMarkInfoView? {return marksCanvas.markInfo}
    public var marksCount:Int                     {return marks.count}
    public var nextMark:MarkInfo?                 {return marks.count==0 ? nil :marks[nextMarkIndex]}
    public func mark(_ index:Int) ->MarkInfo?     {return (marks.count==0 ? nil : (index<0 ? marks.first : (index>=marks.count ? marks.last : marks[index])))}

    
// MARK: - CUSTOMIZATION INTERFACE
    
    public var defaultInfoViewTitleFont:UIFont = UIFont.systemFont(ofSize:20)
    {
        didSet{currentInfoView?.setTitleStyle(font: defaultInfoViewTitleFont, color: defaultInfoViewTitleColor)}
    }
    public var defaultInfoViewTextFont:UIFont = UIFont.systemFont(ofSize:16)
    {
        didSet{currentInfoView?.setTitleStyle(font: defaultInfoViewTitleFont, color: defaultInfoViewTitleColor)}
    }
    public var defaultInfoViewTitleColor:UIColor = UIColor.white
    {
        didSet{currentInfoView?.setTitleStyle(font: defaultInfoViewTitleFont, color: defaultInfoViewTitleColor)}
    }
    public var defaultInfoViewTextColor:UIColor = UIColor.white
    {
        didSet{currentInfoView?.setTitleStyle(font: defaultInfoViewTitleFont, color: defaultInfoViewTitleColor)}
    }
    public func setColors(main:UIColor, echo:UIColor) 
    {
        marksCanvas.ringMainColor=main
        marksCanvas.ringEchoColor=echo;
    }
    public func setDynamics(mainPeriod:Double, aperturePeriod:Double, echoTravel:CGFloat) 
    {
        marksCanvas.ringPeriod=mainPeriod
        marksCanvas.apPeriod=aperturePeriod
        marksCanvas.ecTravel=echoTravel
    }
    public func setEcho(beginOpacity:CGFloat, endOpacity:CGFloat)
    {
        marksCanvas.ecBeginOpacity=beginOpacity
        marksCanvas.ecEndOpacity=endOpacity
    }
    
// MARK: - PROPERTIES
    
    weak var marksContainer:UIView?
    var marksCanvas:CoachMarksCanvas
    
    var marks = [MarkInfo]()
    var handlers = [CoachMarkHandler]()
    var nextMarkIndex:Int = 0
    
    enum Events
    {
        public static let CoachMarkerMarksRequest = Notification.Name("CoachMarkerRegisterMarksRequest")
    }
}

// MARK: - CoachMarkInfoView

public protocol CoachMarkInfoView: class
{
    var viewSize:CGSize      {get}
    var centerOffset:CGPoint {get}
    
    func setInfo(_ info:Any)
    
    func setTextInfo(title:String, info:String)
    func setTitleStyle(font:UIFont, color:UIColor)
    func setInfoStyle(font:UIFont, color:UIColor)
}

extension CoachMarkInfoView where Self: UIView{}

// MARK: - MarkControlHandler

public class CoachMarkHandler
{
    var token:NSObjectProtocol!
    internal init (){}
    deinit
    {
        print("MarkControlHandler deinit: \(self)")
        NotificationCenter.default.removeObserver(token)
    }
}
