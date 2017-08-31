//
//  BaseTableViewController.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/18.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit
import MJRefresh

class BaseTableViewController: BaseViewController {
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshBackNormalFooter()
    let tableView = UITableView.init(frame: .zero, style: .grouped)
    let backToTopBtn = UIButton(type: .custom)
    
    /// 是否可以显示加载更多
    var showLoadMore:Bool?{
        didSet{
            guard let showLoadMore = showLoadMore else { return }
            if showLoadMore {
                footer.isHidden = false
            }else{
                footer.isHidden = true
            }
        }
    }
    
    /// 是否可以显示下拉刷新
    var showRefresh:Bool?{
        didSet{
            guard let showRefresh = showRefresh else { return }
            if showRefresh {
                header.isHidden = false
            }else{
                header.isHidden = true
            }
        }
    }
    
    /// 是否移除所有刷新
    var removedRefreshing:Bool?{
        didSet{
            guard let removedRefreshing = removedRefreshing else { return }
            if removedRefreshing {
                footer.isHidden = true
                header.isHidden = true
            }else{
                footer.isHidden = false
                header.isHidden = false
            }
        }
    }
    
    /// 是否显示返回到顶部按钮
    var showBackToTopBtn:Bool?{
        didSet{
            guard let showBackToTopBtn = showBackToTopBtn else { return }
            if showBackToTopBtn {
                backToTopBtn.isHidden = false
            }else{
                backToTopBtn.isHidden = true
            }
        }
    }
    
    /// 数据源数组
    var dataSource:[Any]?=[["111","222","333"],["aaa","bbb","ccc"],["23"]]{
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        tableView.frame = view.bounds
        tableView.autoresizingMask = .flexibleHeight;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor = UIColor.clear;
        tableView.separatorStyle = .singleLine;
        tableView.tableFooterView = UIView()
        
        backToTopBtn.frame = CGRect(x: view.width - 36 - 20, y: view.height - 36 - 20 - 113, width: 36, height: 36)
//        backToTopBtn.setBackgroundImage(UIImage.init(named: "back_to_top"), for: .normal)
        backToTopBtn.backgroundColor = UIColor.blue
        backToTopBtn.addTarget(self, action: #selector(backToTop), for: .touchUpInside)
        
        header.setRefreshingTarget(self, refreshingAction: #selector(refresh))
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadMore))

        tableView.mj_header = header
        tableView.mj_footer = footer
        
        view.addSubview(tableView)
        view.addSubview(backToTopBtn)
    }
}

// MARK: - 事件监听
extension BaseTableViewController{
    
    /// 下拉刷新
    @objc func refresh() {
        tableView.mj_header.endRefreshing()
    }
    
    /// 上拉加载
    @objc func loadMore(){
        tableView.mj_footer.endRefreshing()
    }
    
    /// 返回顶部
    @objc func backToTop(){
        tableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
}


// MARK: - UITableViewDelegate,UITableViewDataSource
extension BaseTableViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = dataSource?[section] as? [Any] else { return 0}
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseid = "123"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseid)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: reuseid)
        }
        cell?.textLabel?.text = indexPath.description
        guard let cell1 = cell else { return UITableViewCell() }
        return cell1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > view.height + 200 {
            showBackToTopBtn = true
        }else{
            showBackToTopBtn = false
        }
    }
}
