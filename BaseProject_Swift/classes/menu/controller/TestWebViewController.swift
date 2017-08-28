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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("内容开始返回")
        let js = "document.getElementById('header').style.marginTop='-50px';document.getElementById('fixed-tab-pannel').style.marginTop = '0px'"
        webView.evaluateJavaScript(js) { (obj, err) in
            print("obj:\(obj)-------err:\(err)")
            if err == nil{
                webView.height = webView.height - 64
            }
        }
    }
    
    
}
