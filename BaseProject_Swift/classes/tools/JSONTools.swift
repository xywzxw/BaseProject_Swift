//
//  JSONTools.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/18.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONTools {
    /// 本地JSON文件解析
    ///
    /// - Parameter fileName: 文件名
    /// - Returns: JSON对象
    public func parse(fileName:String) -> (JSON?) {
        guard let path = Bundle.main.path(forResource:fileName, ofType: nil) else{
            print("找不到\(fileName)文件")
            return nil
        }
        guard let data = try?Data.init(contentsOf: URL(fileURLWithPath: path)) else {
            print("\(fileName)文件转换成Data类型失败")
            return nil
        }
        return JSON(data:data)
    }
    
    /// JSON字符串解析
    ///
    /// - Parameter string: JSON字符串
    /// - Returns: JSON对象
    public func parse(string:String) -> (JSON?) {
        guard let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false) else{
            print("不合法的JSON字符串")
            return nil
        }
        return JSON(data:data)
    }

}
