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
    
    func addToLocalFavourite(userDto: ItemsDto){
        let realm = try! Realm()
        try! realm.write(){
            let data = FavouritesDto()
            data.id = "\(userDto.id)"
            data.url = userDto.url
            data.name = userDto.name
            data.gravatarId = userDto.gravatarId
            data.avatarurl = userDto.avatarurl
            
            realm.add(data)
        }
    }
    
    func deleteLocalFavourite(id: String){
        do {
            let realm = try Realm()
            
            if let obj = realm.objects(FavouritesDto.self).filter("id = %@", id).first {
                try! realm.write {
                    realm.delete(obj)
                }
            }
            
        } catch let error {
            print("error - \(error.localizedDescription)")
        }
    }
    
    func deleteAllFavourites(){
        let realm = try! Realm()
        let allFavouriteObjects = realm.objects(FavouritesDto.self)

        try! realm.write {
            realm.delete(allFavouriteObjects)
        }
    }
    
    func getLocalItemsData() -> [ItemsDto]{
        return try! Realm().objects(ItemsDto.self).toArray().sorted { $0.name.lowercased() < $1.name.lowercased() }
    }
    
    func getFavouritetemsData() -> [FavouritesDto]{
        return try! Realm().objects(FavouritesDto.self).toArray().sorted { $0.name.lowercased() < $1.name.lowercased() }
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
