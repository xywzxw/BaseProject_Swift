//
//  BaseWebViewController.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/24.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit
import WebKit

class BaseWebViewController: BaseViewController,UIGestureRecognizerDelegate {

    let jsFunctionArray = ["showSendMsg","showMobile","showName","back","alert"]

    var canBack = false
    
    /// webView
    final lazy var webView:WKWebView = {
        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        config.preferences = WKPreferences()
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        
        for obj in self.jsFunctionArray{
            config.userContentController.add(self, name: obj)
        }
        
        let webview = WKWebView.init(frame: CGRect.zero, configuration: config)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        
        webview.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webview.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        return webview
    }()
    
    /// 进度条
    final lazy var progressView:UIProgressView = {
        let pv = UIProgressView(frame: CGRect.zero)
        pv.progressTintColor = UIColor.red //进度颜色
        pv.trackTintColor = UIColor.white   //默认颜色
        return pv
    }()
    
    /// 远程URL字符串
    var urlStr : String?{
        didSet{
            guard let str = urlStr,
                let url = URL(string: str) else { return}
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
    /// 本地html文件名称
    var htmlName:String?{
        didSet{
            guard let path = Bundle.main.path(forResource: htmlName, ofType: nil) else{
                print("\(String(describing: htmlName))文件不存在")
                return
            }
            let url = URL.init(fileURLWithPath: path)
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.webView)
        webView.frame = view.bounds
        webView.addSubview(self.progressView)
        progressView.frame = CGRect(x: 0, y: 0, width: view.width, height: 2)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back_icon"), style: .plain, target: self, action: #selector(back))
        
    }
}

// MARK: -WKScriptMessageHandler
extension BaseWebViewController:WKScriptMessageHandler{
    //JS交互  调用的方法
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("\(message.name)\n\(message.body)")
    }
    
}
// MARK: -WKUIDelegate
extension BaseWebViewController:WKUIDelegate{
    func webViewDidClose(_ webView: WKWebView) {
        print("webViewDidClose")
    }
    // 在JS端调用alert函数时，会触发此代理方法。
    // JS端调用alert时所传的数据可以通过message拿到
    // 在原生得到结果后，需要回调JS，是通过completionHandler回调
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        UIAlertController().alertShow(type: .alert, title: "alert", message: message, array: ["确定"]) { (index, msg) in
            completionHandler();
        }
    }
    // JS端调用confirm函数时，会触发此方法
    // 通过message可以拿到JS端所传的数据
    // 在iOS端显示原生alert得到YES/NO后
    // 通过completionHandler回调给JS端
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        UIAlertController().alertShow(type: .alert, title: "alert", message: "JS调用confirm", array: ["确定","取消"]) { (index, msg) in
            completionHandler(index == 0 ? true : false);
            return
        }
    }
    // JS端调用prompt函数时，会触发此方法
    // 要求输入一段文本
    // 在原生输入得到文本内容后，通过completionHandler回调给JS
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController.init(title: "alert", message: "JS调用输入框", preferredStyle: .alert)
        alert.addTextField { (textFiled) in
            textFiled.textColor = UIColor.red
        }
        let action = UIAlertAction.init(title: "确定", style: .default) { (act) in
            let msg = alert.textFields?.last?.text
            completionHandler((msg?.lengthOfBytes(using: .utf8))! > 0 ? msg :nil)
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: -WKNavigationDelegate
extension BaseWebViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("页面开始加载")
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("内容开始返回")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("页面加载完成")
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("页面加载失败")
    }
}
// MRAK: -KVO
extension BaseWebViewController{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            print("loading")
        }else if keyPath == "title"{
            title = self.webView.title
        }else if keyPath == "estimatedProgress"{
            progressView.progress = Float(self.webView.estimatedProgress)
            if progressView.progress == 1 {
                progressView.isHidden = true
            }else{
                progressView.isHidden = false
            }
        }
        //检测网页是否可以返回
        if self.webView.canGoBack {
            canBack = true
        }else{
            canBack = false
        }
    }
}
extension BaseWebViewController{
    @objc fileprivate func back(){
        if canBack {
            webView.goBack()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}
