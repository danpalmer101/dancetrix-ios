//
//  MarkdownView.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 29/09/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import UIKit
import Down
import FirebaseStorage

@IBDesignable class MarkdownView : UITextView {
    
    @IBInspectable var markdownFirebaseStorageReference: String? {
        didSet {
            #if !TARGET_INTERFACE_BUILDER
            guard let ref = markdownFirebaseStorageReference else {
                return
            }
            
            let firebaseRef = Storage.storage().reference().child(ref)
            
            log.info("Retrieving markdown...")
            
            log.debug("    Downloading markdown from Firebase storage: \(ref)")
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            firebaseRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    log.warning(["...failed to retrieve markdown", error])
                } else {
                    log.debug("    Downloaded CSV from Firebase storage:\(ref)")
                    
                    if let markdown = String(data: data!, encoding: String.Encoding.utf8) {
                        self.setMarkdownText(markdown)
                    }
                    
                    log.info("...Retrieved markdown")
                }
            }
            #endif
        }
    }
    
    func setMarkdownText(_ text: String) {
        do {
            let down = Down.init(markdownString: text)
            
            let stylesheet = "* {font-family: Helvetica; font-size: 14pt; color: white } code, pre { font-family: Menlo }"
            
            let mdString = NSMutableAttributedString(
                attributedString: try down.toAttributedString(
                    DownOptions.smart,
                    stylesheet: stylesheet))
            /*
            if let color = self.textColor {
                mdString.addAttribute(
                    NSAttributedStringKey.foregroundColor,
                    value: color,
                    range: NSMakeRange(0, mdString.length))
            }
            */
            log.debug(mdString.string)
            self.attributedText = mdString
        } catch {
            log.error("Invalid markdown string", text, error.localizedDescription)
        }
    }
    
}
