//
//  TestWebViewController.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/28.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit
import WebKit

class TestWebViewController: BaseWebViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsFunctionArray = ["showSendMsg","showMobile","showName","back","alert"]
    }
    
    override func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("内容开始返回")
        let js = "document.getElementById('header').style.marginTop='-50px';document.getElementById('fixed-tab-pannel').style.marginTop = '0px'"
        webView.evaluateJavaScript(js) { (obj, err) in
            if err == nil{
                webView.height = webView.height - 64
            }
        }
    }
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "back" {
            self.navigationController?.popViewController(animated: true)
        }
        else{
            print("name:\(message.name)------body:\(message.body)")
        }
    }
    
    
}
