//
//  AppDelegate.swift
//  TravelTainan
//
//  Created by 馮謙 on 2018/4/29.
//  Copyright © 2018年 馮謙. All rights reserved.
//

import UIKit

class ConsumeMainViewController: BaseMainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 導覽列標題
        self.title = "餐廳"
        
        // 獲取類型
        self.fetchType = "consume"
        
        // 新竹景點資料 ID
        self.strTargetID = "https://www.twtainan.net/opendata/consumeApi?category=0&township=0&type=JSON"//=======================//
        
        
        self.targetUrl = self.documentsPath + self.fetchType + ".json"
        
        // 取得 API 資料
        self.addData()
        
    }
    
    override func goDetail(_ index: Int) {
        let thisData = self.apiData[self.apiDataForDistance[index].index]
        let title = thisData["name"]!! as! String
        let intro = thisData["introduction"]!! as! String
        let opentime = thisData["opentime"]!! as! String
        let tempType = thisData["category"] as! NSArray
        let type = tempType.componentsJoined(by: ", ")
        let address = thisData["address"]!! as! String
        let tel = thisData["tel"]!! as! String
        
        var latitude = 0.0
        var num = thisData["lat"]!! as! Double
        latitude = Double(num)
        
        var longitude = 0.0
        num = thisData["long"]!! as! Double
        longitude = Double(num)
        
        print(type)
        print(latitude, longitude)
        
        let info: [String:AnyObject] = [
            "title" : title as AnyObject,
            "intro" : intro as AnyObject,
            "type" : type as AnyObject,
            "address" : address as AnyObject,
            "opentime" : opentime as AnyObject,
            "tel" : tel as AnyObject,
            "latitude" : latitude as AnyObject,
            "longitude" : longitude as AnyObject,
            ]
        
        let detailViewController = ConsumeDetailViewController()
        detailViewController.info = info
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    
    
    
}
