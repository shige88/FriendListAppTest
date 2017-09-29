//
//  RealmBaseDao.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/24.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import Foundation
import RealmSwift

class RealmBaseDao <T : RealmSwift.Object> {
    let realm: Realm
    init() {
        try! realm = Realm()
    }
    //as?はダウンキャストが成功するかわからない時に使用
    func newId() -> Int? {
        guard let key = T.primaryKey() else {
            //primaryKey未設定
            return nil
        }
        
        if let last = realm.objects(T.self).last as? RealmSwift.Object,
            let lastId = last[key] as? Int {
            return lastId + 1
        } else {
            return 1
        }
    }
    func findAll() -> Results<T> {
        return realm.objects(T.self)
    }
    func findFirst(key: AnyObject) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    func findLast() -> T? {
        return findAll().last
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
}
