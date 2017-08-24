//
//  PagerViewController.swift
//  LXFFM_Demo
//
//  Created by Rainy on 2016/12/1.
//  Copyright © 2016年 Rainy. All rights reserved.
//
import UIKit
import SnapKit

class PagerViewController: BaseViewController {

    lazy var subviewTitles:[String] = {
        let array = ["推荐", "分类","广播","榜单","主播","广播","榜单","主播"]
        return array
    }()
    
    lazy var titleView:PagerTitleView = {
        let manager = PagerTitleView(frame:CGRect.init(x: 0, y: 0, width: kScreenW, height: 44))
        manager.delegate = self
        self.view.addSubview(manager)
        return manager
    }()
    lazy var pageMagager:PageManagerVC = {
        let vc1 = BaseWebViewController()
        vc1.urlStr = "http://m.selanwang.com"
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.randomColor()
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.randomColor()
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.randomColor()
        let vc5 = UIViewController()
        vc5.view.backgroundColor = UIColor.randomColor()
        let vc6 = UIViewController()
        vc6.view.backgroundColor = UIColor.randomColor()
        let vc7 = UIViewController()
        vc7.view.backgroundColor = UIColor.randomColor()
        let vc8 = UIViewController()
        vc8.view.backgroundColor = UIColor.randomColor()
        
        let manager = PageManagerVC.init(superController: self, childControllerS: [vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8])
        manager.delegate = self
        self.view.addSubview(manager.view)
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        titleView.title_font = UIFont.systemFont(ofSize: 15)
        titleView.sliderWidthType = .ButtonWidth
        titleView.title_array = subviewTitles
        setConstraint()
    }
    fileprivate func setConstraint(){
        
        pageMagager.view.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-49)
        }
    }

}

extension PagerViewController:TitleViewDelegate,pageManagerDelegate{
    func pageTitleDidSelected(_ titleView: PagerTitleView, index: NSInteger, title: String){
        pageMagager.setCurrentVCWithIndex(index)
    }
    func pageManagerDidFinishSelectedVC(indexOfVC: NSInteger) {
        titleView.reloadSelectedBT(at: indexOfVC)
    }
}













