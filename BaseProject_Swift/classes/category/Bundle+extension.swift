//
//  Bundle+extension.swift
//  SwiftProject
//
//  Created by 吾爷科技 on 2017/8/14.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import Foundation
extension Bundle{
    //计算型属性类似于函数，没有参数，有返回值
    var namespace : String{
        return infoDictionary?["CFBundleExecutable"] as? String ?? ""
    }
    
}
