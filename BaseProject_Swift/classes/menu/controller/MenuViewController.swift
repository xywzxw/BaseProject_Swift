//
//  MenuViewController.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/18.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let web = TestWebViewController()
//        web.urlStr = "http://m.selanwang.com/tmpl/product_info.html?goods_id=12311"
        web.htmlName = "js.html"
        self.navigationController?.pushViewController(web, animated: true)
        
    }
}
