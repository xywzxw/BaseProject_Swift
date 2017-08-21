//
//  TestTableViewController.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/21.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit

class TestTableViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.removedRefreshing = true
        dataSource = [["111","222","333"],["aaa","bbb","ccc"],["dddddd","2222","23"],["111","222","333"],["aaa","bbb","ccc"],["dddddd","2222","23"],["111","222","333"],["aaa","bbb","ccc"],["dddddd","2222","23"],["111","222","333"],["aaa","bbb","ccc"],["dddddd","2222","23"]]
        self.showBackToTopBtn = true
    }
    override func refresh() {
        super.refresh()
        print("下拉刷新")
    }
    override func loadMore() {
        super.loadMore()
        print("上拉加载")
    }
}
