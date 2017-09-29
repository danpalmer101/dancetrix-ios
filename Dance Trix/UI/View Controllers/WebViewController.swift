//
//  WebViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 29/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    var cssFileName : String?
    var url : String!
    
    @IBOutlet
    var webContainerView : UIView!
    
    var webView : WKWebView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        
        if (self.cssFileName != nil) {
            if let path = Bundle.main.path(forResource: self.cssFileName, ofType: "css") {
                let cssString = try! String(contentsOfFile: path)
                                        .trimmingCharacters(in: .whitespacesAndNewlines)
                                        .replacingOccurrences(of: "\n", with: "")
                let jsString = String(format: "var styleTag = document.createElement(\"style\"); styleTag.textContent = \"%@\"; document.documentElement.appendChild(styleTag);", cssString)
                let userScript = WKUserScript(source: jsString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
 
                let userContentController = WKUserContentController()
                userContentController.addUserScript(userScript)
                config.userContentController = userContentController
            }
        }
        
        self.webView = WKWebView.init(frame: CGRect.zero, configuration: config)
        self.webView.navigationDelegate = self
        
        if (self.url != nil) {
            self.webView.load(URLRequest(url: URL(string: self.url)!))
        }
        
        self.webContainerView.addSubview(self.webView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.webView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: self.webContainerView.frame.size.width,
                                    height: self.webContainerView.frame.size.height)
    }
    
    // MARK: - WK delegates
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        log.info(message)
    }

}
