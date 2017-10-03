//
//  SendGridEmailService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import SendGrid

class SendGridEmailService : EmailServiceType {

    private let subjectFileNameFormat = "%@_subject"
    private let bodyPlainFileNameFormat = "%@_body_plain"
    private let bodyHtmlFileNameFormat = "%@_body_html"
    
    init() {
        // "danpalmer101" account, "Dance Trix iOS" key
        Session.shared.authentication = Authentication.apiKey("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")
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
        if let fileContent = getFileContents(fileName: String(format: bodyPlainFileNameFormat, templateName)) {
            content.append(Content(contentType: ContentType.plainText, value: fileContent))
        } else {
            log.warning(String(format:"Unable to find plain file content for %@", templateName))
        }
        if let fileContent = getFileContents(fileName: String(format: bodyHtmlFileNameFormat, templateName)) {
            content.append(Content(contentType: ContentType.htmlText, value: fileContent))
        } else {
            log.warning(String(format:"Unable to find HTML file content for %@", templateName))
        }
        
        // Build subject content from template file
        let subject = getFileContents(fileName: String(format: subjectFileNameFormat, templateName))
        
        if (subject == nil) {
            log.warning(String(format:"Unable to find subject file content for %@", templateName))
        }
        
        let email = Email(personalizations: personalizations,
                          from: Address(email: from),
                          content: content,
                          subject: subject)
        
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
    
    private func getFileContents(fileName: String, fileExtension: String = "mustache") -> String? {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            return try! String(contentsOfFile: path).trimmingCharacters(in: CharacterSet(charactersIn: " \n"))
        }
        
        return nil
    }
    
}
