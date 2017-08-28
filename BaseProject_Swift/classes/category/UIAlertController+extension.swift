//
//  UIAlertController+extension.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/18.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit

extension UIAlertController{
    
    public func alertShow(type:UIAlertControllerStyle,title:String,message:String, array: [String], callBack:@escaping ((_ index : Int, _ title: String) -> Swift.Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: type)
        
        for i in 0..<array.count {
            let action = UIAlertAction(title: array[i], style: i == array.count - 1 ? .destructive:.default, handler: { (action) in
                callBack(i,array[i])
            })
            alert .addAction(action)
        }
        viewController()?.present(alert, animated: true, completion: nil)
    }

}
