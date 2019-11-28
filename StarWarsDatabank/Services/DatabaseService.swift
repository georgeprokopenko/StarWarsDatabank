//
//  DatabaseService.swift
//  StarWarsDatabank
//
//  Created by George Prokopenko on 26/11/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit
import RealmSwift

class DatabaseService<T> where T: Object {
    func saveObject(_ object: T) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(object, update: .modified)
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
    
    func deleteObject(_ object: T) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(object)
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
    
    func savedObjects() -> [T]? {
        do {
            let realm = try Realm()
            return realm.objects(T.self).map { $0 }
        }
        catch (let error) {
            print(error)
            return nil
        }
    }
}
