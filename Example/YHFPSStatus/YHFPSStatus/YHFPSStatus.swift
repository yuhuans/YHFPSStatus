//
//  YHFPSStatus.swift
//  YHFPSStatus
//
//  Created by apple on 23/3/17.
//  Copyright © 2017年 于欢. All rights reserved.
//

import UIKit
class YHFPSStatus: NSObject {
    private var fpsLabel = UILabel ()
    private var displayLink = CADisplayLink()
    private var lastTime = TimeInterval()
    private var count = NSInteger()
    static let sharedInstance:YHFPSStatus = YHFPSStatus()
    typealias fpsHandler=(NSInteger)->()
    var fpsChange: fpsHandler!

    class func shared() ->YHFPSStatus {
        return sharedInstance
    }


    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActiveNotification), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActiveNotification), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        displayLink=CADisplayLink.init(target: self, selector: #selector (displayLinkTick(link: )))
        displayLink.isPaused=true
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        fpsLabel = UILabel.init(frame:CGRect(x: 120, y: 0, width: 100, height: 20) )
        fpsLabel.font = UIFont.systemFont(ofSize: 12)
        fpsLabel.tag=101
    }
    func open (){
        let rootVCViewSubViews : Array = UIApplication.shared.delegate!.window!!.rootViewController!.view.subviews
        for label in rootVCViewSubViews {
            if label is UILabel && label.tag==0x1001 {
                return
            }
        }
        displayLink.isPaused=false
        UIApplication.shared.delegate!.window!!.rootViewController!.view.addSubview(fpsLabel)
    }
    func close (){
        displayLink.isPaused=true
        let rootVCViewSubViews : Array = UIApplication.shared.delegate!.window!!.rootViewController!.view.subviews
        for label in rootVCViewSubViews {
            if label is UILabel && label.tag==0x1001 {
                label.removeFromSuperview()
                return
            }
        }
    }
    
    @objc private func applicationDidBecomeActiveNotification() {
        displayLink.isPaused=false
    }
    @objc private func applicationWillResignActiveNotification() {
        displayLink.isPaused=true
    }
    func openWithHandler(handler: @escaping fpsHandler){
        YHFPSStatus.shared().open()
        fpsChange=handler
    }
    @objc private func displayLinkTick(link: CADisplayLink){
        if lastTime==0 {
            lastTime=link.timestamp
            return
        }
        count = count+1
        let interval = link.timestamp-lastTime
        if interval < 1 {
            return
        }
        lastTime=link.timestamp
        
        let fps  = Double(count)/interval
        count=0
        fpsLabel.text=String.init(stringLiteral: "\(round(fps))")
        
        if (self.fpsChange != nil) {
            self.fpsChange((NSInteger(round(fps))))
        }
    }
    deinit {
        displayLink.isPaused=true
        displayLink.remove(from: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
}

