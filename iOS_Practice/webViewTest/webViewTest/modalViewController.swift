//
//  modalViewController.swift
//  webViewTest
//
//  Created by 이현호 on 2023/08/09.
//

import Foundation
import UIKit
import WebKit

class modalViewController: UIViewController{
      
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string:"https://www.youtube.com/")!)
        webView.load(request)
          
 
      }
}
