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
    
    static func fromRegistrationEmailAddress() -> String {
        return getRemoteConfig("email_address_registration_from")
    }
    
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
    
    // Remove config - Feature
    
    static func registrationEnabled() -> Bool {
        return isTrue(getRemoteConfig("feature_registration"))
    }
    
    static func bookClassEnabled() -> Bool {
        return isTrue(getRemoteConfig("feature_book"))
    }
    
    static func importantDatesEnabled() -> Bool {
        return isTrue(getRemoteConfig("feature_important_dates"))
    }
    
    static func calendarEnabled() -> Bool {
        return isTrue(getRemoteConfig("feature_calendar"))
    }
    
    static func paymentEnabled() -> Bool {
        return isTrue(getRemoteConfig("feature_payment"))
    }
    
    static func uniformEnabled() -> Bool {
        return isTrue(getRemoteConfig("feature_uniform"))
    }
    
    static func aboutEnabled() -> Bool {
        return isTrue(getRemoteConfig("feature_about"))
    }
    
    // Tools
    
    private static func isTrue(_ string: String) -> Bool {
        return ["yes", "true", "1"].contains(string.lowercased())
    }
    
    private static func checkCommandLine(_ arg : String) -> Bool {
        return CommandLine.arguments.contains(arg)
    }
    
    private static func getRemoteConfig(_ key : String) -> String {
        return RemoteConfig.remoteConfig().configValue(forKey: key).stringValue!
    }
    
}
