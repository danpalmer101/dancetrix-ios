//
//  Configuration.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

class Configuration {
    
    // Command line configuration
    
    static func isMockServicesEnabled() -> Bool {
        return checkCommandLine("-DTMockServicesEnabled")
    }
    
    static func isMockEmailEnabled() -> Bool {
        return checkCommandLine("-DTMockEmailEnabled")
    }
    
    static func isPreferenceCleaningEnabled() -> Bool {
        return checkCommandLine("-DTPreferencesClean")
    }
    
    // Remote config - Emails
    
    static func fromPaymentEmailAddress() -> String {
        return getRemoteConfig("email_address_payment_from")
    }
    
    static func fromBookingEmailAddress() -> String {
        return getRemoteConfig("email_address_booking_from")
    }
    
    static func fromUniformOrderEmailAddress() -> String {
        return getRemoteConfig("email_address_uniform_from")
    }
    
    static func toEmailAddress() -> String {
        return getRemoteConfig("email_address_to")
    }
    
    static func mailgunApiKey() -> String {
        return getRemoteConfig("mailgun_api_key")
    }
    
    static func mailgunDomain() -> String {
        return getRemoteConfig("mailgun_domain")
    }
    
    // Remote config - Website
 
    static func websiteUrl() -> String {
        return getRemoteConfig("dancetrix_website")
    }
    
    static func uniformCatalogUrl() -> String {
        return getRemoteConfig("dancetrix_uniform_catalog")
    }
    
    // Tools
    
    private static func checkCommandLine(_ arg : String) -> Bool {
        return CommandLine.arguments.contains(arg)
    }
    
    private static func getRemoteConfig(_ key : String) -> String {
        return RemoteConfig.remoteConfig().configValue(forKey: key).stringValue!
    }
    
}
