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
// MARK: - INIT
    
    public init(in container:UIView) 
    {
        marksContainer = container
        marksCanvas = CoachMarksCanvas(frame:container.bounds)
        marksCanvas.markInfo = DefaultCoachMarkInfoView(frame:container.bounds)
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
        DispatchQueue.main.async(execute:{NotificationCenter.default.post(name:Events.CoachMarkerMarksRequest, object:self)})
    }
    deinit 
    {
        destroy()
    }
    
// MARK: - MARKS REGISTER INTERFACE
    
    public func registerMark(position:CGPoint, aperture:CGFloat, title:String, info:String, control:Any? = nil)
    {
        let mark = MarkInfo(position:position, aperture:aperture, control:control, textInfo:(title,info), info:nil, infoView:nil)
        marks.append(mark)
    }
    
    public func registerMark(position:CGPoint, aperture:CGFloat, info:Any, control:Any? = nil)
    {
        let mark = MarkInfo(position:position, aperture:aperture, control:control, textInfo:nil, info:info, infoView:nil)
        marks.append(mark)
    }
    
    public func registerMark(position:CGPoint, aperture:CGFloat, info:Any?, infoView:CoachMarkInfoView, control:Any? = nil)
    {
        let mark = MarkInfo(position:position, aperture:aperture, control:control, textInfo:nil, info:info, infoView:infoView)
        marks.append(mark)
    }
    
// MARK: - CONTROL INTERFACE
    
    public func showNextMark()
    {
        guard marks.count > 0 else {return}
        showMark(at:nextMarkIndex)
        nextMarkIndex = (nextMarkIndex+1)%marks.count
    }
    public func showMark(at index:Int)
    {
        guard marks.count > 0 else {return}
        guard let mark = getMark(at: index) else {return}
        marksCanvas.replaceCurrentMark(with:mark)
    }
    public func resetMarks()
    {
        marks.removeAll()
        
        nextMarkIndex = 0
        DispatchQueue.main.async(execute:{NotificationCenter.default.post(name:Events.CoachMarkerMarksRequest, object:self)})
    }
    public func cleanup()
    {
        marksCanvas.removeCurrentMark(completion: {})
        
    }
    public func destroy()
    {
        marksCanvas.removeCurrentMark
        {
            self.marksCanvas.removeFromSuperview()
        }
    }
    
// MARK: - ACCESS INTERFACE
    
    public func getCurrentInfoView() ->CoachMarkInfoView? {return marksCanvas.markInfo}
    public func getMarksCount() ->Int                     {return marks.count}
    public func getMark(at index:Int) ->MarkInfo?         {return (marks.count==0 ? nil : (index<0 ? marks.first : (index>=marks.count ? marks.last : marks[index])))}
    
// MARK: - PRPERTIES
    
    weak var marksContainer:UIView?
    var marksCanvas:CoachMarksCanvas
    
    var marks = [MarkInfo]()
    var nextMarkIndex:Int = 0
    
    public enum Events
    {
        public static let CoachMarkerMarksRequest = Notification.Name("CoachMarkerMarksRequest")
    }
    
    public struct MarkInfo
    {
        let position:CGPoint
        let aperture:CGFloat
        let control:Any?
        let textInfo:(String,String)?
        let info:Any?
        let infoView:CoachMarkInfoView?
    }
}

// MARK: - CoachMarkInfoView

public protocol CoachMarkInfoView: class
{
    var viewSize:CGSize      {get}
    var centerOffset:CGPoint {get}
    
    func setTextInfo(title:String, info:String)
    func setInfo(_ info:Any)
}

extension CoachMarkInfoView where Self: UIView{}
