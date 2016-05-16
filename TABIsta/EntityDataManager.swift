//
//  EntityDataManager.swift
//  TABIsta
//
//  Created by System on 2016/05/13.
//  Copyright © 2016年 DIP Corporation. All rights reserved.
//

import RealmSwift

class EntityDataManager: NSObject {
    // MARK: - PickupMedia
    static func getAllPickupMedia() -> Results<MediaEntity> {
        let realm = try! Realm()
        let items = realm.objects(MediaEntity)
        return items;
    }
    
    static func addPickupMedia(item:MediaEntity) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(item)
        }
    }
    
    static func deletePickupMedia(item:MediaEntity) {
        let realm = try! Realm()
        let deleteItem = self.getAllPickupMedia().filter("id == " + String(item.id))
        try! realm.write {
            realm.delete(deleteItem)
        }
    }
    
    static func deleteAllPickupMedia() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    // MARK: - Login
    
}
