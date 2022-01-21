//
//  LocalDb.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import RealmSwift

class LocalDb{
    
    func getLocalItemsData() -> [ItemsDto]{
        return try! Realm().objects(ItemsDto.self).toArray()
    }
}

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
