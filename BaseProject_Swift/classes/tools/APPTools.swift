//
//  APPTools.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/21.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit

class APPTools: NSObject {
    func appVersion() -> (String) {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return "0.0"}
        return version
    }
}
