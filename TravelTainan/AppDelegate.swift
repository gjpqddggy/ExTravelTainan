//
//  AppDelegate.swift
//  TravelTainan
//
//  Created by 馮謙 on 2018/4/29.
//  Copyright © 2018年 馮謙. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var mylocationManager: CLLocationManager!
    var myUserDefaults: UserDefaults!
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 取得定位服務授權
        self.myUserDefaults = UserDefaults.standard
        
        // 建立一個 CLLocationManager
        mylocationManager = CLLocationManager()
        mylocationManager.delegate = self
        mylocationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        mylocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // 取得定位服務授權
            mylocationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            
            self.myUserDefaults.synchronize()
        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            
            // 更新記錄的座標 for 取得有限數量的資料
            for type in ["landmark", "park", "hotel"] {
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLatitude")
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLongitude")
            }
            
            self.myUserDefaults.synchronize()
        }
        
        // 設立導覽列預設顏色
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 0.24, green: 0.79, blue: 0.83, alpha: 1)
        
        // 設定導覽列預設按鈕顏色
        UINavigationBar.appearance().tintColor = UIColor.black
        
        // 建立一個UIWindow
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // 設置底色
        self.window!.backgroundColor = UIColor.white
        
        // 建立 UITabBarController
        let myTabBar = UITabBarController()
        
        // 設置標籤列
        // 使用 UITabBarController 的屬性 tabBar 的各個屬性設置
        myTabBar.tabBar.backgroundColor = UIColor.clear
        
        // 建立 景點 頁示
        let landmarkViewController = UINavigationController(rootViewController: LandmarkMainViewController())
        landmarkViewController.tabBarItem = UITabBarItem(title: "景點", image: UIImage(named: "landmark"), tag: 0)
        
        // 建立 公園 頁示
        let consumeViewController = UINavigationController(rootViewController: ConsumeMainViewController())
        consumeViewController.tabBarItem = UITabBarItem(title: "餐廳", image: UIImage(named: "consume"), tag: 0)
        
        // 建立 住宿 頁示
        let hotelViewController = UINavigationController(rootViewController: HotelMainViewController())
        hotelViewController.tabBarItem = UITabBarItem(title: "住宿", image: UIImage(named: "hotel"), tag: 0)
        
        // 建立 關於 頁示
        let infoViewController = UINavigationController(rootViewController: InfoMainViewController())
        infoViewController.tabBarItem = UITabBarItem(title: "關於", image: UIImage(named: "info"), tag: 0)
        
        // 加入到 UITabBarController
        myTabBar.viewControllers = [landmarkViewController, consumeViewController, hotelViewController, infoViewController]
        
        // 設置根視圖控制器
        self.window!.rootViewController = myTabBar
        
        // 將 UIWindow 設置為可見的
        self.window!.makeKeyAndVisible()
        
        return true
    }

    // 更改定位權限時執行
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController(title: "定位服務已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        } else if status == CLAuthorizationStatus.authorizedWhenInUse {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
    }


}

