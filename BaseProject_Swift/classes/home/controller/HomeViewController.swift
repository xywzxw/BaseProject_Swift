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
        view.backgroundColor = UIColor.colorHex(hex: "0xffff00")
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

        
        let alert = UIAlertController().alertShow(type: .alert,title: "title", message: "这里是提示信息",array:["aaa","cancle"]){
            (index,msg) in
                print("\(index)-------\(msg)")
            }
        self.present(alert, animated: true, completion: nil)
    }
}
