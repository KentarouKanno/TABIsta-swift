//
//  UIImage+Extension.swift
//  TABIsta
//
//  Created by KentarOu on 2016/05/21.
//  Copyright © 2016年 DIP Corporation. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        
        // MainViewController
        case GourmetOn   = "MainMap-GenreGourmetOnButton"
        case GourmetOff  = "MainMap-GenreGourmetOffButton"
        case ShoppingOn  = "MainMap-GenreShoppingOnButton"
        case ShoppingOff = "MainMap-GenreShoppingOffButton"
        case SpotOn      = "MainMap-GenreSpotOnButton"
        case SpotOff     = "MainMap-GenreSpotOffButton"
        
        // OtherViewConroller....
    }
}

extension UIImage {
    #if DEBUG
    convenience init(assetIdentifier: AssetIdentifier) {
    
        guard let _ = UIImage(named: assetIdentifier.rawValue) else {
            fatalError("No Image Failer... ImageName = \(assetIdentifier.rawValue)")
        }
        self.init(named: assetIdentifier.rawValue)!
    }
    #elseif RELEASE
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue) // No Failer... return nil
    }
    #endif
}
