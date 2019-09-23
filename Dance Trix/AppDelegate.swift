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
import FirebaseMessaging
import UserNotifications
import Reachability
import Fabric
import Crashlytics

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    let reachability = Reachability()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        enableLogging()
        enableReachabilityCheck()
        enableFabric()
        enableFirebase()
        enableRemoteConfig()
        enableNotificationsOnApplication(application)
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
    }
    
    func enableRemoteConfig() {
        RemoteConfig.remoteConfig().setDefaults(fromPlist: "Configuration")
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 60) { (status, error) in
            RemoteConfig.remoteConfig().activateFetched()
            
            NotificationCenter.default.post(
                name: .remoteConfigUpdated,
                object: nil)
        }
    }
    
    func enableNotificationsOnApplication(_ application : UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        Messaging.messaging().delegate = self
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        application.registerForRemoteNotifications()
    }
    
    func enablePreferences() {
        if (Configuration.isPreferenceCleaningEnabled()) {
            Preferences.cleanAll()
        }
    }
    
    func applyBranding() {
        Theme.applyGlobal(window: window)
    }
    
    // Handling notifications
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        log.warning("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        log.debug("Refreshed FCM registration token: \(fcmToken)")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // Title
        var title = notification.request.content.title
        if (title.isEmpty) {
            title = "Notification"
        }
        
        // Text
        let text = notification.request.content.body
        if (text.isEmpty) {
            log.warning("Empty notification sent, not displaying anything")
            return
        }
        
        // Type
        var type : NotificationType;
        switch (notification.request.content.userInfo["type"] as? String ?? "success") {
        case "success": type = .success ; break ;
        case "warning": type = .warning ; break ;
        case "info": type = .info ; break ;
        case "error": type = .error ; break ;
        default: type = .success
        }
        
        Notification.show(title: title, subtitle: text, type: type)
        
        completionHandler([])
    }
    
}
