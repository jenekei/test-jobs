//
//  webPr.swift
//  WebSample
//
//  Created by Jene de Borja on 31/10/2019.
//  Copyright © 2019 xxx. All rights reserved.
//

import Foundation
import UIKit
import WebKit

protocol webPrDelegate: NSObjectProtocol {
    func updateUI(progress:Float, eBack:Bool, eForward:Bool)
    func RefreshEnabled()
    func error(error: Error)
}


class webPrView : WKWebView, WKNavigationDelegate, WKUIDelegate
{
   
    weak private var webPrViewDelegate : webPrDelegate?
    private var GeBack:Bool = false
    private var GeForward:Bool = false
    private var Gsuccess:Bool = false
    
    public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame:frame, configuration:configuration)
        
        self.navigationDelegate = self
       
        self.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        self.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
        self.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

    }
    
    
    func setPrDelegate(webPrViewDelegate:webPrDelegate?){
        self.webPrViewDelegate = webPrViewDelegate
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath ==  #keyPath(WKWebView.canGoForward))  || (keyPath ==  #keyPath(WKWebView.canGoBack))  || (keyPath ==  #keyPath(WKWebView.estimatedProgress)){
     
             self.webPrViewDelegate?.updateUI(progress: Float(self.estimatedProgress), eBack: self.canGoBack, eForward: self.canGoForward)
        }
     
    }
    

    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
         self.webPrViewDelegate?.error(error: error)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webPrViewDelegate?.RefreshEnabled()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        self.webPrViewDelegate?.error(error: error)
    }
    
}
