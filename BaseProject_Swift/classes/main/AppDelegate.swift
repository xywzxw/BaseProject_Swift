//
//  AppDelegate.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/18.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 键盘扩展
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
        // 实时检查网络状态
        NetWorkTools.share.checkNetworkStates()

        //友盟配置
        configUMeng(launchOptions: launchOptions)
        
        
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

// MARK: - 友盟配置
extension AppDelegate:UNUserNotificationCenterDelegate{
    fileprivate func configUMeng(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self

            let types10 = UNAuthorizationOptions.badge.rawValue|UNAuthorizationOptions.alert.rawValue|UNAuthorizationOptions.alert.rawValue
            
            center.requestAuthorization(options: UNAuthorizationOptions(rawValue: types10), completionHandler: { (granted, error) in
                if granted {
                    //点击允许
                    //这里可以添加一些自己的逻辑
                } else {
                    //点击不允许
                    //这里可以添加一些自己的逻辑
                }
            })
            
        } else {
            // Fallback on earlier versions
        }
        
        
        
        //基本配置
        guard let config = UMAnalyticsConfig.sharedInstance() else {
            print("友盟UMAnalyticsConfig初始化失败")
            return
        }
        guard let dict = JSONTools().parse(fileName: "ConfigKey.json") else { return }
        guard let um_app_key = dict["um_app_key"].string,
            let qq_app_key = dict["qq_app_id"].string,
            let qq_redirect_url = dict["qq_redirect_url"].string,
            let wx_app_key
            = dict["wx_app_key"].string,
            let wx_app_secret = dict["wx_app_secret"].string,
            let wb_app_key = dict["wb_app_key"].string,
            let wb_app_secret = dict["wb_app_secret"].string,
            let wb_redirect_url = dict["wb_redirect_url"].string
        else {
            print("获取的APPKey中有空值")
            return
        }
        
        config.appKey = um_app_key
        config.channelId = "App Store"
        MobClick.start(withConfigure: config)
        MobClick.setAppVersion(APPTools().appVersion())
        
        //友盟推送
        UMessage.start(withAppkey: um_app_key, launchOptions: launchOptions)
        //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
        UMessage.registerForRemoteNotifications()
        UMessage.openDebugMode(true)
        //打开日志，方便调试
        UMessage.setLogEnabled(true)
        
        //友盟分享
        guard let manager = UMSocialManager.default() else {
            return
        }
        //打开调试日志
        manager.openLog(true)
        //设置友盟appkey
        manager.umSocialAppkey = um_app_key
        
        //配置QQ
        manager.setPlaform(.QQ, appKey: qq_app_key, appSecret: nil, redirectURL: qq_redirect_url)
        //配置微信
        manager.setPlaform(.wechatSession, appKey: wx_app_key, appSecret: wx_app_secret, redirectURL: nil)
        //移除相应平台的分享
        manager.removePlatformProvider(withPlatformTypes: [UMSocialPlatformType.wechatFavorite.rawValue])
        //配置新浪
        manager.setPlaform(.sina, appKey: wb_app_key, appSecret: wb_app_secret, redirectURL: wb_redirect_url)
    }
}
