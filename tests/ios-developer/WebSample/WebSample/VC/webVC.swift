//
//  webVC.swift
//  WebSample
//
//  Created by Jene de Borja on 31/10/2019.
//  Copyright © 2019 xxx. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class webVC: UIViewController,  webPrDelegate
{
    
    let webex = webPrView()
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var botBar: UIToolbar!
    
    var LoadThisURL : String = "https://github.com/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        webex.setPrDelegate(webPrViewDelegate:self)

        view.insertSubview(webex, belowSubview: progressView)
        webex.translatesAutoresizingMaskIntoConstraints = false
        let topspace = NSLayoutConstraint(item: webex, attribute: .top, relatedBy: .equal, toItem: self.navBar, attribute: .bottom, multiplier: 1, constant:0)
        let botspace = NSLayoutConstraint(item: webex, attribute: .bottom, relatedBy: .equal, toItem: self.botBar, attribute: .top, multiplier: 1, constant:0)
        let width = NSLayoutConstraint(item: webex, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        view.addConstraints([topspace, botspace, width])
        

        
        let myURL = URL(string: LoadThisURL)
        let myreq = URLRequest(url: myURL!)
        webex.load(myreq)
        
        
        
    }
    
    
    @IBAction func back(sender: UIBarButtonItem) { webex.goBack() }
    
    @IBAction func forward(sender: UIBarButtonItem) {  webex.goForward() }
    
    @IBAction func reload(sender: UIBarButtonItem) {
        let request = NSURLRequest(url:webex.url!)
        webex.load(request as URLRequest)
    }

    
    func updateUI(progress:Float, eBack:Bool, eForward:Bool)
    {
        backButton.isEnabled = eBack
        forwardButton.isEnabled = eForward
        progressView.isHidden = false
        progressView.setProgress(progress, animated: true)
    }
    
    func RefreshEnabled()
    {
        progressView.setProgress(0.0, animated: false)
        progressView.isHidden = true
        reloadButton.isEnabled  = true
    }
    
    func error (error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
