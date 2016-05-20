//
//  MainMapViewModel.swift
//  TABIsta
//
//  Created by System on 2016/05/16.
//  Copyright © 2016年 DIP Corporation. All rights reserved.
//

import MapKit
import UIKit

var locationManager: CLLocationManager?

// MARK: - MapView
/*** mapView初期化 ***/
func initMapView(view:MKMapView) -> MKMapView {
    var region:MKCoordinateRegion = view.region
    region.span.latitudeDelta = 0.02
    region.span.longitudeDelta = 0.02
    view.setRegion(region,animated:true)
    
    return view
}

/*** 位置情報関連初期化 ***/
func initLocationManager() -> CLLocationManager {
    let locationManager = CLLocationManager()
    locationManager.requestAlwaysAuthorization()
    locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation
    locationManager.pausesLocationUpdatesAutomatically=true
    locationManager.distanceFilter=100.0
    return locationManager
}

/*** 現在地を表示 ***/
func movePresentLocation(view:MKMapView, newLocation:CLLocation) {
    let location = CLLocationCoordinate2DMake(newLocation.coordinate.latitude,
                                              newLocation.coordinate.longitude)
    view.setCenterCoordinate(location, animated: true)
    
    // 表示領域設定
    var region: MKCoordinateRegion = view.region
    region.center = location
    region.span.latitudeDelta = 0.02
    region.span.longitudeDelta = 0.02
    
    // 現在地表示
    view.setRegion(region, animated: true)
    
    // 位置情報取得停止
    locationManager?.stopUpdatingLocation()
}


// MARK: - PhotoView
/*** 写真項目セル作成 ***/
func createCollectionViewCell(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell:CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
    cell.title.text = "#Wikiki Beach";
    cell.image.image = UIImage(named: "test")
    cell.backgroundColor = UIColor.whiteColor()
    return cell
}

func getCollectionViewCellSize(column: CGFloat, margin:CGFloat, ratio:CGFloat) -> CGSize {
    let size: CGSize = UIScreen.mainScreen().bounds.size
    let width = (size.width - (margin * (column + 1))) / column
    let height = width * ratio
    return CGSize(width: width, height: height)
}
