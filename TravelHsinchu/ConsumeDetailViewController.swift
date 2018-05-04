//
//  AppDelegate.swift
//  TravelTainan
//
//  Created by 馮謙 on 2018/4/29.
//  Copyright © 2018年 馮謙. All rights reserved.
//
import UIKit

class ConsumeDetailViewController: DetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchType = "consume"
        
        let latitude = info["latitude"] as? Double ?? 0.0
        let longitude = info["longitude"] as? Double ?? 0.0
        hasMap = (latitude == 0.0 && longitude == 0.0) ? false : true
        
        // 設置資訊
        detail = [
            "地圖",
            info["type"] as? String ?? "",
            info["tel"] as? String ?? "",
            info["address"] as? String ?? "",
            info["opentime"] as? String ?? "",
            info["intro"] as? String ?? ""
        ]
        
        self.title = info["title"] as? String ?? "標題"
        
    }
    
    
}
