//
//  FriendListDB.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/24.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import Foundation
import RealmSwift
class FriendObject: Object{
    @objc dynamic var id = Int()
    @objc dynamic var name = String()
    @objc dynamic var gender = String()
    @objc dynamic var other1 = String()
    @objc dynamic var other2 = String()
    @objc dynamic var image = NSData()
    
    override static func primaryKey() -> String?{
        return "id"
    }
}




class RealmBaseDao <T : RealmSwift.Object> {
    let realm: Realm
    init() {
        try! realm = Realm()
    }
    
    //as?はダウンキャストが成功するかわからない時に使用
    func newId() -> Int? {
        guard let key = T.primaryKey() else {
            return nil
        }        
        if let last = realm.objects(T.self).last,
            let lastId = last[key] as? Int {
            return lastId + 1
        } else {
            return 1
        }
    }
    func find(key: AnyObject) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    func findAll() -> Results<T> {
        return realm.objects(T.self)
    }
    func add(d :T) {
        do {
            try realm.write {
                realm.add(d)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    //変更
    func update(d: T, block:(() -> Void)? = nil) -> Bool {
        do {
            try realm.write {
                block?()
                realm.add(d, update: true)
            }
            return true
        } catch let error as NSError {
            print(error.description)
        }
        return false
    }
    func delete(d: T) {
        do {
            try realm.write {
                realm.delete(d)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    func deleteAll() {
        let objs = realm.objects(T.self)
        do {
            try realm.write {
                realm.delete(objs)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }

}

