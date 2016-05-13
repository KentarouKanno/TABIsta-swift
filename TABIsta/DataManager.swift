//
//  DataManager.swift
//  TABIsta
//
//  Created by System on 2016/05/13.
//  Copyright © 2016年 DIP Corporation. All rights reserved.
//

import RealmSwift

class DataManager: NSObject {
    static func getPickupMedia() -> [MediaEntity] {
        let rtn = [MediaEntity(), MediaEntity()]
        return rtn;
    }
}
