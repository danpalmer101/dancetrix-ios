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
 
    static func websiteUrl() -> String {
        return getRemoteConfig("dancetrix_website")
    }
    
    static func uniformCatalogUrl() -> String {
        return getRemoteConfig("dancetrix_uniform_catalog")
    }
    
    static func getRemoteConfig(_ key : String) -> String {
        return RemoteConfig.remoteConfig().configValue(forKey: key).stringValue!
    }
    
}
