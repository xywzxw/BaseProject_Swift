//
//  NSObject+extension.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/21.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import Foundation
extension NSObject{
    func viewController() -> UIViewController? {
        
        var vc:UIViewController?
        guard let wind = UIApplication.shared.keyWindow else {
            vc = UIViewController()
            return vc
        }
        var window = wind
        if window.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows
            for i in 0 ..< windows.count{
                let win = windows[i]
                if win.windowLevel == UIWindowLevelNormal {
                    window = win
                    break
                }
            }
        }
        var result = window.rootViewController

        while (result?.presentedViewController != nil) {
            result = result?.presentedViewController;
        }
        //tabbar下主控制器
        if (result?.isKind(of: BaseTabBarController.classForCoder()))! {
            result = (result as?BaseTabBarController )?.selectedViewController
        }
        //非主控制器
        if (result?.isKind(of: BaseNavigationController.classForCoder()))! {
            result = (result as?BaseNavigationController )?.topViewController
        }
        return result
    }
}
