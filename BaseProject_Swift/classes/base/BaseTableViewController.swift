//
//  BaseTableViewController.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/18.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {
    var dataSource:[Any]? = [["aa":["1","2"]],["bb":["111","222"]]]{
        didSet{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
    }


}
