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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let tf = UITextField.init(frame: CGRect(x: 50, y: 5, width: 200, height: 40))
        tf.backgroundColor = UIColor.gray
        cell.contentView.addSubview(tf)
        return cell
        
        
    }
}
