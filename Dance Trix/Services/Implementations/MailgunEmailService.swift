//
//  MailgunEmailService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import Mustache
import SwiftMailgun

class MailgunEmailService : EmailServiceType {

    private let subjectFileNameFormat = "%@_subject"
    private let bodyPlainFileNameFormat = "%@_body_plain"
    private let bodyHtmlFileNameFormat = "%@_body_html"
    
    private let mailgun: MailgunAPI
    
    private let dateFormatter = DateFormatter()
    private let dateTimeFormatter = DateFormatter()
    private let currencyFormatter = NumberFormatter()
    
    init() {
        // d.palmer101 account
        self.mailgun = MailgunAPI(apiKey: Configuration.mailgunApiKey(),
                                  clientDomain: Configuration.mailgunDomain())
        
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
        self.dateTimeFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.currencyFormatter.numberStyle = .currency
        self.currencyFormatter.currencyCode = "GBP"
    }
    
    func sendEmail(templateName: String,
                   from: String,
                   to: String,
                   templateVariables: [String : Any?],
                   successHandler: @escaping () -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        
        log.info("Sending email...")
        
        let email  = MailgunEmail()
        email.from = from
        email.to = to
        
        log.debug("Sending email to \(to) from \(from)")
        
        do {
            let template = try Template(named: String(format: bodyPlainFileNameFormat, templateName))
            registerFormatters(template: template)
            let rendering = try template.render(templateVariables)
            email.text = trim(rendering)!
            
            log.debug("Plain:\n\(email.text!)")
        } catch {
            log.warning("Unable to render plain file content for \(templateName)")
            log.warning([error])
        }
        
        do {
            let template = try Template(named: String(format: bodyHtmlFileNameFormat, templateName))
            registerFormatters(template: template)
            let rendering = try template.render(templateVariables)
            email.html = trim(rendering)!
            
            log.debug("HTML:\n\(email.html!)")
        } catch {
            log.warning("Unable to render HTML file content for \(templateName)")
            log.warning([error])
        }
        
        do {
            let template = try Template(named: String(format: subjectFileNameFormat, templateName))
            registerFormatters(template: template)
            email.subject = try template.render(templateVariables)
            
            log.debug("Subject:\n\(email.subject!)")
        } catch {
            log.warning("Unable to render subject file content for \(templateName)")
            log.warning([error])
        }
        
        // Send
        DispatchQueue.global().async {
            self.send(email: email,
                      successHandler: successHandler,
                      errorHandler: errorHandler)
        }
    }
    
    func send(email: MailgunEmail,
              successHandler: @escaping () -> Void,
              errorHandler: @escaping (Error) -> Void) {
    
        mailgun.sendEmail(email) { (result) in
            if (result.success) {
                log.info("...email successfully sent")
                
                successHandler()
            } else {
                log.warning("...error sending email via Mailgun, message = \(result.message ?? "<null>")")
                
                errorHandler(EmailError.unableToSend(message: result.message))
            }
        }
    }
    
    private func trim(_ text: String?) -> String? {
        return text?.trimmingCharacters(in: CharacterSet(charactersIn: " \n"))
    }
    
    private func registerFormatters(template: Template) {
        template.register(self.dateFormatter, forKey: "dateFormat")
        template.register(self.dateTimeFormatter, forKey: "dateTimeFormat")
        template.register(self.currencyFormatter, forKey: "currencyFormat")
        template.register(StandardLibrary.each, forKey: "each")
        template.register(StandardLibrary.zip, forKey: "zip")
    }
    
}
