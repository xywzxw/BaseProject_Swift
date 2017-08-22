//
//  HomeViewController.swift
//  BaseProject_Swift
//
//  Created by 吾爷科技 on 2017/8/18.
//  Copyright © 2017年 飓风逍遥. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        //图片数组
        let imagesArr = ["second.jpeg","third.jpeg","fourth.jpeg","fifth.jpeg","sixth.jpeg","seventh.jpeg","eighth.jpg"]
        
        //创建轮播视图
        let scrollView = PictureSliderView(frame: CGRect(x: 0, y: 0, width: view.width, height: 200))
        view.addSubview(scrollView)
        scrollView.pageControl?.currentPageIndicatorTintColor = UIColor.red
        
        //展示图片
        scrollView.imageArray = imagesArr
        
        //是否自动轮播
        scrollView.isAutoScroll = true
        
        //切换时间间隔（可不设置，默认三秒）
        //scrollView.autoScrollDeley = 1
        
        //点击屏幕中间图片回调
        scrollView.blockWithClick = {(senderCLick : Int) ->() in
            print(senderCLick)
        }

        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        NetWorkTools.request(type: .get, urlString: "http://c.selanwang.com", parameters: nil) { (result, data, error) in
        //            if result{
        //                print(data["code"].intValue)
        //            }
        //        }
        
        //        let jsonStr = "[{\"name\": \"hangge\", \"age\": 100, \"phones\": [{\"name\": \"公司\",\"number\": \"123456\"}, {\"name\": \"家庭\",\"number\": \"001\"}]}, {\"name\": \"big boss\",\"age\": 1,\"phones\": [{ \"name\": \"公司\",\"number\": \"111111\"}]}]"
        //        guard let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return  }
        //        let json = JSON(data: jsonData)
        //        print(json)
        
        //        guard let json = JSONTools().parse(fileName: "TabBar.json") else { return }
        //        print(json)
        
        
        UIAlertController().alertShow(type: .alert,title: "title", message: "这里是提示信息",array:["aaa","cancle"]){
            (index,msg:String) in
            if msg == "cancle"{
                print("返回")
            }else{
                print("aaa")
            }
        }
    }
}
