//
//  VideoViewController.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/31.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit

class VideoViewController: BaseViewController {
    // 播放器视图
    lazy var playerView: LYPlayerView = {
        let playerView = LYPlayerView(urlString: "http://flv2.bn.netease.com/tvmrepo/2017/3/K/I/ECF9KFDKI/SD/ECF9KFDKI-mobile.mp4")
        playerView.delegate = self as? LYPlayerViewDelegate
        return playerView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    deinit {
        print("VideoViewController已销毁")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(playerView)
        // 播放器
        playerView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.right.equalTo(view)
            make.height.equalTo(playerView.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(nextVideo), for: .touchUpInside)
        btn.setTitle("下一视频", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.sizeToFit()
        btn.center = view.center

        view.addSubview(btn)
        
    }
    @objc func nextVideo(){
        playerView.player.url = URL(string: "http://ongelo4u0.bkt.clouddn.com/15011427040376xWtn.mp4")
    }

}
