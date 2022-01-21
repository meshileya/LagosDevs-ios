//
//  LocalDb.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import RealmSwift

class LocalDb{
    
    let PAGE_NUMBER = "pageNumber"
    let TOTAL_COUNT = "totalCount"
    
    func getLocalItemsData() -> [ItemsDto]{
        return try! Realm().objects(ItemsDto.self).toArray()
    }
    
    func saveCurrentPage (pageNumber:String){
        let defaults = UserDefaults.standard
        defaults.set(pageNumber, forKey: PAGE_NUMBER)
    }
    
    func getCurrentPage() -> Int{
        return UserDefaults.standard.integer(forKey: PAGE_NUMBER)
    }
    
    func totalNumberOfItems (count:String){
        let defaults = UserDefaults.standard
        defaults.set(count, forKey: TOTAL_COUNT)
    }
    
    func getTotalItemsNumber() -> Int{
        return UserDefaults.standard.integer(forKey: TOTAL_COUNT)
    }
}

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
