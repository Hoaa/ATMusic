//
//  AppDelegate.swift
//  ATMusic
//
//  Created by Nguyen Thanh Su on 8/1/16.
//  Copyright © 2016 at. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

let kAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate

enum RepeatType {
    case None
    case One
    case All
}

let kNotification = NSNotificationCenter.defaultCenter()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var detailPlayerVC: DetailPlayerViewController?
    var repeating: RepeatType = .None
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = BaseTabBarController()
        setupRemoteControl()
        window?.makeKeyAndVisible()
        return true
    }

    private func setupRemoteControl() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: [])
            try AVAudioSession.sharedInstance().setActive(true)
            UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
            detailPlayerVC?.becomeFirstResponder()
        } catch {
            print(error)
        }
    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        if let remoteControl = event?.subtype {
            switch remoteControl {
            case .RemoteControlPlay:
                detailPlayerVC?.play()
            case .RemoteControlPause:
                detailPlayerVC?.pause()
            case .RemoteControlPreviousTrack:
                MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPNowPlayingInfoPropertyPlaybackRate: 0.0]
                detailPlayerVC?.previousSong()
            case .RemoteControlNextTrack:
                MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPNowPlayingInfoPropertyPlaybackRate: 0.0]
                detailPlayerVC?.nextSong()
            default: break
            }
        }
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
}
