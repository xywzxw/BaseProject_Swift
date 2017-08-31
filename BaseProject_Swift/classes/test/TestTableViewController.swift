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
        self.removedRefreshing = true
        dataSource = [["webView"],["瀑布流"],["视频"]]
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
        let sec = dataSource?[indexPath.section] as? [String]
        cell.textLabel?.text = sec?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        switch indexPath.section {
        case 0:
            let web = TestWebViewController()
            web.htmlName = "js.html"
            navigationController?.pushViewController(web, animated: true)
        case 1:
            print("瀑布流")
        case 2:
            let video = VideoViewController()
            navigationController?.pushViewController(video, animated: true)
        default:
            print("其他")
        }
        
        
        print(indexPath)
    }
    
}
