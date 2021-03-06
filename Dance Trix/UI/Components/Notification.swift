//
//  Notification.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 29/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import RMessage

enum NotificationType {
    case info
    case warning
    case error
	case success
}

class Notification {
    
    private static var typeMap : [NotificationType: RMessageType] = [
        .info:    .normal,
        .warning: .warning,
        .error:   .error,
        .success: .success
    ]
    
    static func show(title: String, subtitle: String, type: NotificationType, endless : Bool = false) {
        // Always in main thread
        DispatchQueue.main.async {
            if (endless) {
                RMessage.showNotification(withTitle: title,
                                          subtitle: subtitle,
                                          type: typeMap[type] ?? .normal,
                                          customTypeName: nil,
                                          duration: TimeInterval(RMessageDuration.endless.rawValue),
                                          callback: nil,
                                          canBeDismissedByUser: true)
            } else {
                RMessage.showNotification(withTitle: title,
                                          subtitle: subtitle,
                                          type: typeMap[type] ?? .normal,
                                          customTypeName: nil,
                                          callback: nil)
            }
        }
        
    }
    
}
