//
//  SendGridEmailService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import SendGrid
import Mustache

class SendGridEmailService : EmailServiceType {

    private let subjectFileNameFormat = "%@_subject"
    private let bodyPlainFileNameFormat = "%@_body_plain"
    private let bodyHtmlFileNameFormat = "%@_body_html"
    
    private let dateFormatter = DateFormatter()
    private let dateTimeFormatter = DateFormatter()
    private let currencyFormatter = NumberFormatter()
    
    init() {
        // "danpalmer101" account, "Dance Trix iOS" key
        Session.shared.authentication = Authentication.apiKey("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")
        
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
        self.dateTimeFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.currencyFormatter.numberStyle = .currency
        self.currencyFormatter.currencyCode = "GBP"
    }
    
    func sendEmail(templateName: String,
                   from: String,
                   to: [String],
                   templateVariables: [String : Any?],
                   successHandler: @escaping () -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        
        log.info("Sending email...")
        
        // Recipients
        let addresses = to.map { (address: String) -> Address in return Address(email: address) }
        let personalizations = [Personalization(to: addresses)]
        
        // Build plain and html content from template files
        var content = [Content]()
        
        do {
            let template = try Template(named: String(format: bodyPlainFileNameFormat, templateName))
            registerFormatters(template: template)
            let rendering = try template.render(templateVariables)
            content.append(Content(contentType: .plainText, value: trim(rendering)!))
        } catch {
            log.warning(String(format:"Unable to render plain file content for %@", templateName))
            log.warning([error])
        }
        
        do {
            let template = try Template(named: String(format: bodyHtmlFileNameFormat, templateName))
            registerFormatters(template: template)
            let rendering = try template.render(templateVariables)
            content.append(Content(contentType: .htmlText, value: trim(rendering)!))
        } catch {
            log.warning(String(format:"Unable to render HTML file content for %@", templateName))
            log.warning([error])
        }
        
        var subject: String?
        do {
            let template = try Template(named: String(format: subjectFileNameFormat, templateName))
            registerFormatters(template: template)
            subject = try template.render(templateVariables)
        } catch {
            log.warning(String(format:"Unable to render subject file content for %@", templateName))
            log.warning([error])
        }
        
        let email = Email(personalizations: personalizations,
                          from: Address(email: from),
                          content: content,
                          subject: trim(subject))
        
        // Send
        DispatchQueue.global().async {
            self.send(email: email,
                      successHandler: successHandler,
                      errorHandler: errorHandler)
        }
    }
    
    func send(email: Email,
              successHandler: @escaping () -> Void,
              errorHandler: @escaping (Error) -> Void) {
        do {
            try Session.shared.send(request: email)
            
            log.info("...email successfully sent")
            
            successHandler()
        } catch {
            log.warning(["...error sending email via SendGrid", error])
            errorHandler(error)
        }
    }
    
    private func trim(_ text: String?) -> String? {
        return text?.trimmingCharacters(in: CharacterSet(charactersIn: " \n"))
    }
    
    private func registerFormatters(template: Template) {
        template.register(self.dateFormatter, forKey: "dateFormat")
        template.register(self.dateTimeFormatter, forKey: "dateTimeFormat")
        template.register(self.currencyFormatter, forKey: "currencyFormat")
    }
    
}
