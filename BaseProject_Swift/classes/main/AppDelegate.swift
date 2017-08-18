//
//  AppDelegate.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/18.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var reacha: Reachability? // 监听网络状态
    var preNetWorkStatus: NetworkStatuses? // 之前的网络状态

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 键盘扩展
        IQKeyboardManager.sharedManager().enable = true
        // 实时检查网络状态
        checkNetworkStates()

        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController =  BaseTabBarController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
    }

}
// MARK: - 网络状态检测
extension AppDelegate {
    fileprivate func checkNetworkStates() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.networkChange), name: NSNotification.Name.reachabilityChanged, object: nil)
        reacha = Reachability.init(hostName: "http://www.jianshu.com/collection/105dc167b43b")
        reacha?.startNotifier()
    }
    
    @objc fileprivate func networkChange() {
        var tips: NSString = ""
        guard let currentNetWorkStatus = NetWorkTools.getNetworkStates() else { return }
        if currentNetWorkStatus == preNetWorkStatus { return }
        preNetWorkStatus = currentNetWorkStatus
        switch currentNetWorkStatus {
        case .NetworkStatusNone:
            tips = "" // 设置
            let alertView = UIAlertView(title: "设置网络", message: "", cancleTitle: "好的", otherButtonTitle: ["设置"], onDismissBlock: { (index) in // app-Prefs:root=WIFI
                guard let url = URL(string: "App-Prefs:root=com.zxw.jfxy.swift") else {
                    return
                }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }, onCancleBlock:nil)
            alertView.show()
            break
        case .NetworkStatus2G,.NetworkStatus3G,.NetworkStatus4G:
            tips = "当前是移动网络，请注意你的流量"
            break
        case .NetworkStatusWIFI:
            tips = ""
            break
        }
        
        print(tips.lengthOfBytes(using: String.Encoding.utf16.rawValue))
        let length = tips.lengthOfBytes(using: String.Encoding.utf16.rawValue)
        if length > 0 {
            let alertView = UIAlertView(title: "明明科技", message: tips as String, delegate: nil, cancelButtonTitle: "好的")
            alertView.show()
            
        }
    }
}

