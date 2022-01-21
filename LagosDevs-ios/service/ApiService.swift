//
//  ApiService.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import Alamofire
import RealmSwift

class ApiService{
    
    typealias CompletionHandler = (_ result: Bool, _ data: Int, _ error: Error?) -> Void
    
    let realm = try! Realm()
    lazy var itemsDto: Results<ItemsDto> = { self.realm.objects(ItemsDto.self) }()
    
    func fetchUsersAsync(pageNumber: String, handler: @escaping CompletionHandler){
        Alamofire.request("https://api.github.com/search/users?q=lagos&page=\(pageNumber)", method: .get, parameters: nil, headers : nil).responseJSON
        {
                response in
                switch response.result {
                case .success(_):
                    guard let data = response.data else { return }
                    
                   do {
                       let decoder = JSONDecoder()
                       let mainResponse = try decoder.decode(MainResponse.self, from: data)
                       try! self.realm.write(){
                       self.realm.add(mainResponse.items.map({ (item) -> ItemsDto in
                           let data = ItemsDto()
                           data.id = "\(item.id)"
                           data.url = item.url
                           data.name = item.login
                           data.gravatarId = item.gravatarId
                           data.avatarurl = item.avatarUrl
                           return ItemsDto(value: data)
                       }))
                       }
                       LocalDb().saveCurrentPage(pageNumber: pageNumber)
                       handler(true, mainResponse.totalCount, nil)
                     } catch let error {
                         print(error)
                         handler(true,-1, nil)
                    }
                    
                case .failure(let error):
                    handler(false,-1, error)
                }
        }
        }
    
}
