//
//  BaseTabBarController.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/18.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.white;
        createController()
//        setNavBarAppearence()
    }
}
extension BaseTabBarController{
    fileprivate func createController(){
        guard let array = JSONTools().parse(fileName: "TabBar.json") else { return }
        var arrayM = [BaseNavigationController]();
        for i in 0..<array.count{
            let obj = array[i]
            arrayM.append(controller(dict:obj))
        }
        viewControllers = arrayM
    }
    
    fileprivate func controller(dict:JSON)->BaseNavigationController{
        guard let clsName = dict["cls"].string,
            let title = dict["title"].string,
            let imageName = dict["image"].string,
            let selectImage = dict["select_image"].string,
            let cls = NSClassFromString(Bundle.main.namespace + "."+clsName) as?BaseViewController.Type
            else {
                return BaseNavigationController()
        }
        
        //2.创建视图控制器
        let vc = cls.init()
        
        
        //设置tabBar文字
        vc.title = title
        //设置tabBar图片
        vc.tabBarItem.image = UIImage.init(named: imageName)
        //设置tabBar选中图片
        vc.tabBarItem.selectedImage = UIImage.init(named: selectImage)?.withRenderingMode(.alwaysOriginal)
        
        //设置tabBar文字颜色
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: .highlighted)
        //设置tabBar文字大小(系统默认12号)
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12)], for: .normal)
        let nav = BaseNavigationController(rootViewController:vc)
        nav.navigationBar.isTranslucent = false
        
        
        return nav
    }
    fileprivate func setNavBarAppearence()
    {
        // 设置导航栏默认的背景颜色
        UIColor.defaultNavBarBarTintColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
        // 设置导航栏所有按钮的默认颜色
        UIColor.defaultNavBarTintColor = .white
        // 设置导航栏标题默认颜色
        UIColor.defaultNavBarTitleColor = .gray
        // 统一设置状态栏样式
        UIColor.defaultStatusBarStyle = .lightContent
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        // UIColor.defaultShadowImageHidden = true
    }

}
