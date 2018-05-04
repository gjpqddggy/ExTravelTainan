//
//  AppDelegate.swift
//  TravelTainan
//
//  Created by 馮謙 on 2018/4/29.
//  Copyright © 2018年 馮謙. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    let fullsize = UIScreen.main.bounds.size
    let myUserDefaults :UserDefaults = UserDefaults.standard
    var fetchType :String = ""
    var info :[String:AnyObject]! = nil
    var latitude :Double = 0.0
    var longitude :Double = 0.0
    var myMapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 樣式
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        latitude = info["latitude"] as? Double ?? 0.0
        longitude = info["longitude"] as? Double ?? 0.0
        
        //self.title = info["title"] as? String ?? "標題"
        
        
        // 建立一個 MKMapView
        myMapView = MKMapView(frame: CGRect(x: 0, y: 20, width: fullsize.width, height: fullsize.height - 20))
        
        // 設置委任對象
        myMapView.delegate = self
        
        // 地圖樣式
        myMapView.mapType = .standard
        
        // 顯示自身定位位置
        myMapView.showsUserLocation = true
        
        // 允許縮放地圖
        myMapView.isZoomEnabled = true
        
        // 地圖預設顯示的範圍大小 (數字越小越精確)
        let latDelta = 0.005
        let longDelta = 0.005
        let currentLocationSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        // 設置地圖顯示的範圍與中心點座標
        let center: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentRegion: MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        myMapView.setRegion(currentRegion, animated: true)
        
        // 加入到畫面中
        self.view.addSubview(myMapView)
        
        // 建立一個地點圖示 (圖示預設為紅色大頭針)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: latitude, longitude: longitude).coordinate
        objectAnnotation.title = info["title"] as? String ?? "標題"
        myMapView.addAnnotation(objectAnnotation)
        

        
    }

    
}
