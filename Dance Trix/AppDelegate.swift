//
//  AppDelegate.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import SwiftyBeaver
import Firebase
import Reachability
import Fabric
import Crashlytics

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = Reachability()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        enableLogging()
        
        enableReachabilityCheck()
        
        enableFabric()
        
        enableFirebase()
        
        enablePreferences()
        
        applyBranding()
        
        return true
    }
    
    func enableLogging() {
        // define log destination
        let console = ConsoleDestination()  // log to Xcode Console
        
        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss$d $L $M"
        
        // add the destination(s) to SwiftyBeaver
        log.addDestination(console)
    }
    
    func enableReachabilityCheck() {
        self.reachability.whenUnreachable = { _ in
            Notification.show(title: "No internet connection",
                              subtitle: "Some features may not be available. Tap to dismiss.",
                              type: .warning,
                              endless: true)
        }
        
        do {
            try self.reachability.startNotifier()
        } catch {
            log.warning("Unable to start Reachability notifier")
        }
    }
    
    func enableFabric() {
        Fabric.with([Crashlytics.self])
    }
    
    func enableFirebase() {
        FirebaseApp.configure()
        RemoteConfig.remoteConfig().setDefaults(fromPlist: "Configuration")
        
        RemoteConfig.remoteConfig().fetch { (status, error) in
            RemoteConfig.remoteConfig().activateFetched()
            
            NotificationCenter.default.post(
                name: .remoteConfigUpdated,
                object: nil)
        }
    }
    
    func enablePreferences() {
        if (Configuration.isPreferenceCleaningEnabled()) {
            Preferences.cleanAll()
        }
    }
    
    func applyBranding() {
        Theme.applyGlobal(window: window)
    }
    
}
