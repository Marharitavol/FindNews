//
//  RealmManager.swift
//  FindNews
//
//  Created by Rita on 09.02.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    func saveArticle(_ article: RealmModel) {
        do {
            let localRealm = try Realm()
            try localRealm.write {
                localRealm.add(article)
            }
        } catch {
            print("save Error")
        }
    }
    
    func deleteArticle(_ model: RealmModel) {
        do {
            let localRealm = try Realm()
            try! localRealm.write {
                //localRealm.delete(model)
                localRealm.delete(localRealm.objects(RealmModel.self))
//                                    .filter {$0.urlImage == model.urlImage})
            }
        } catch {
            print("deleting Error")
        }
    }
    
    func fetchArticle(completion: @escaping (_ articleArray: [RealmModel]?) -> Void) {
        do {
            let localRealm = try Realm()
            let articleResults = localRealm.objects(RealmModel.self)
            completion(Array(articleResults))
        } catch {
            print("fetchHistory error")
        }
    }
}



