//
//  PreviewViewController.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 11/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit
import WebKit

class PreviewViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var previewUrl: String?
    
    override func viewDidLoad() {
        webView.isHidden = true
        previewUrl?.append("?playsinline=1")
        
        if let preview = previewUrl, let url = URL(string: preview) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        webView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        webView.isHidden = false
        
        
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(3.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        self.webView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

