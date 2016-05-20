//
//  MainMapViewController.swift
//  TABIsta
//
//  Created by System on 2016/05/12.
//  Copyright © 2016年 DIP Corporation. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MainMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate,
                                UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var mapView: MKMapView!                  // マップ
    @IBOutlet weak var collectionView: UICollectionView!    // 写真一覧
    @IBOutlet weak var settingButton: UIButton!             // 設定ボタン
    @IBOutlet weak var presentLocationButton: UIButton!     // 現在地ボタン
    @IBOutlet weak var genreGourmetButton: UIButton!        // グルメボタン
    @IBOutlet weak var genreShoppingButton: UIButton!       // ショッピングボタン
    @IBOutlet weak var genreSpotButton: UIButton!           // スポットボタン
    @IBOutlet weak var layoutCollectionViewHeight: NSLayoutConstraint!
    var locationManager:CLLocationManager!
    var collectionViewMaxHeight: CGFloat {
        return UIScreen.mainScreen().bounds.height - 200
    }
    let collectionViewHandleHeight: CGFloat = 40
    let collectionViewColumnNum: Int = 2
    let collectionViewColumnMargin: CGFloat = 10
    let collectionViewWidthHeightRatio: CGFloat = 1.3
    
    enum TagType: Int {
        case setting = 100
        case presentLocation
        case gourmet
        case shopping
        case spot
        case collectionHandle = 200
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAnalytics.logEventWithName(kFIREventSignUp, parameters: nil)
        // 初期化
        initItem()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        
        let isLandscape = UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)
        let perRow = collectionViewColumnNum + (isLandscape ? 1 : 0)
        adaptBeautifulGrid(perRow, gridLineSpace: 10.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - UserEvent
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        
        if let touchEvent = touches.first {
            if touchEvent.view?.tag == TagType.collectionHandle.rawValue {
                // collectionViewを上下スライド
                let dy = touchEvent.locationInView(view).y - touchEvent.previousLocationInView(view).y
                let height = layoutCollectionViewHeight.constant - dy
                if collectionViewHandleHeight < height && height < collectionViewMaxHeight {
                    layoutCollectionViewHeight.constant = height
                }
            }
        }
    }
    
    @IBAction func pushButtonMapView(sender: UIButton) {
        switch sender.tag {
        case TagType.setting.rawValue:
            // 設定ボタン
            transitionViewController("Setting")
            
        case TagType.presentLocation.rawValue:
            // 現在地ボタン
            locationManager?.startUpdatingLocation()
            
        case TagType.gourmet.rawValue:
            // グルメボタン
            sender.selected = !sender.selected;
            if (sender.selected) {
                sender.setImage(UIImage(named: "MainMap-GenreGourmetOnButton"), forState: .Normal)
            } else {
                sender.setImage(UIImage(named: "MainMap-GenreGourmetOffButton"), forState: .Normal)
            }
        case TagType.shopping.rawValue:
            // ショッピングボタン
            sender.selected = !sender.selected;
            if (sender.selected) {
                sender.setImage(UIImage(named: "MainMap-GenreShoppingOnButton"), forState: .Normal)
            } else {
                sender.setImage(UIImage(named: "MainMap-GenreShoppingOffButton"), forState: .Normal)
            }
                
        case TagType.spot.rawValue:
            // スポットボタン
            sender.selected = !sender.selected;
            if (sender.selected) {
                sender.setImage(UIImage(named: "MainMap-GenreSpotOnButton"), forState: .Normal)
            } else {
                sender.setImage(UIImage(named: "MainMap-GenreSpotOffButton"), forState: .Normal)
            }
            
        default: break
        }
    }
        
    // MARK: - LocationManager Delegate
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        movePresentLocation(mapView, newLocation: newLocation)
    }
    
    // MARK: - UICollectionView Delegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return createCollectionViewCell(collectionView, cellForItemAtIndexPath: indexPath)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50;
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        transitionViewController("PhotoDetail")
    }
    
    // MARK: - PrivateMethod
    /*** 初期化 **/
    func initItem() {
        // mapView
        self.mapView = initMapView(self.mapView)
        self.mapView.delegate=self
        
        // collectionView
        self.collectionView.delegate = self
        
        // locationManager
        self.locationManager = initLocationManager()
        self.locationManager.delegate=self
        
        //現在地の取得を開始
        self.locationManager.startUpdatingLocation()
        
        // 端末回転時のイベント登録
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainMapViewController.orientationChange), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    /***  画面遷移 ***/
    func transitionViewController(name: String) {
        let storyboard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController()! as UIViewController
        presentViewController(next, animated: true, completion: nil)
    }
    
    /*** 端末回転時にCollectionViewの高さを調節 ***/
    func orientationChange()  {
        if layoutCollectionViewHeight.constant > collectionViewMaxHeight {
            layoutCollectionViewHeight.constant = collectionViewMaxHeight
        }
    }
    
    
    
    func adaptBeautifulGrid(numberOfGridsPerRow: Int, gridLineSpace space: CGFloat) {
        let inset = UIEdgeInsets( top: 0, left: space, bottom: space, right: space)
        adaptBeautifulGrid(numberOfGridsPerRow, gridLineSpace: space, sectionInset: inset)
    }
    
    func adaptBeautifulGrid(numberOfGridsPerRow: Int, gridLineSpace space: CGFloat, sectionInset inset: UIEdgeInsets) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        guard numberOfGridsPerRow > 0 else {
            return
        }
        let isScrollDirectionVertical = layout.scrollDirection == .Vertical
        var length = isScrollDirectionVertical ? collectionView.frame.width : collectionView.frame.height
        length -= space * CGFloat(numberOfGridsPerRow - 1)
        length -= isScrollDirectionVertical ? (inset.left + inset.right) : (inset.top + inset.bottom)
        let side = length / CGFloat(numberOfGridsPerRow)
        guard side > 0.0 else {
            return
        }
        layout.itemSize = CGSize(width: side, height: side * collectionViewWidthHeightRatio)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = inset
        layout.invalidateLayout()
    }
}
