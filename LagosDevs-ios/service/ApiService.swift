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
    
    typealias CompletionHandler = (_ result: Bool, _ data: [Items], _ error: Error?) -> Void
    
    var countryRates : [Items] = []
    let realm = try! Realm()
    lazy var itemsDto: Results<ItemsDto> = { self.realm.objects(ItemsDto.self) }()
    
    func fetchUsersAsync(handler: @escaping CompletionHandler){
        Alamofire.request("https://api.github.com/search/users?q=lagos&page=1", method: .get, parameters: nil, headers : nil).responseJSON
            {
                response in
                switch response.result {
                case .success(let value):
//                    let decoder = JSONDecoder()
                    print("VALUE: \(value)")
                    print("RESPONSE DATA : \(response.data)")
                    guard let data = response.data else { return }
                    
                   do {
                       let decoder = JSONDecoder()
                       let mainResponse = try decoder.decode(MainResponse.self, from: data)
                       let items = mainResponse.items
                       try! self.realm.write(){
//                           for user in items {
//                               let data = ItemsDto()
//                               data.id = "\(user.id)"
//                               data.url = user.url
//                               data.gravatarId = user.gravatarId
//                               self.realm.add(data)
//                           }
                       self.realm.add(items.map({ (item) -> ItemsDto in
                           let data = ItemsDto()
                           data.id = "\(item.id)"
                           data.url = item.url
                           data.name = item.login
                           data.gravatarId = item.gravatarId
                           data.avatarurl = item.avatarUrl
                           return ItemsDto(value: data)
                       }))
                       }
                       
                       handler(true,items, nil)
                     } catch let error {
                         print(error)
                         handler(true,[], nil)
//                                    completion(nil)
                    }
                    
                    
//                    let mainResponse = try decoder.decode(MainResponse.self, from: data)
//
//                    handler(true,mainResponse.items, nil)
                    
//                    let json = JSON(value)
//                    let rates: Dictionary<String, JSON> = json["rates"].dictionaryValue
//                    try! self.realm.write(){
//                        for item in rates {
//                            self.countryRates.append(RatesModel(countryCode: item.key, countryRate: item.value.double ?? 0.0))
//                            let rate = Rates()
//                            rate.countryCode = item.key
//                            rate.currencyValue = item.value.double ?? 0.0
//                            rate.dateObject = Date()
//                            self.realm.add(rate)
//                        }
//                        self.historyData = self.realm.objects(Rates.self)
//                    }
//
//                    handler(true,self.countryRates, nil)
                case .failure(let error):
                    handler(false,self.countryRates, error)
                }
        }
    }
    
//    func loginCall(firebaseToken: String, email: String, password: String, handler: @escaping CompletionHandler){
//        let parameters: Parameters=[
//            "fcm_token": firebaseToken,
//            "email": email,
//            "password": password
//        ]
//
//        print(parameters)
//
//        Alamofire.request("login", method: .post, parameters: parameters, encoding: URLEncoding.default, headers : nil).responseJSON
//            {
//                response in
//                print("LOGIN DETAILS")
//                print(response)
//                switch response.result {
//                case .success(let value):
////                    let decoder = JSONDecoder()
////                    let mainResponse = try decoder.decode(MainResponse.self, from: data)
////
////                    handler(true,mainResponse.items, nil)
//
//                    guard let data = response.data else { return }
//                                do {
//                                    let decoder = JSONDecoder()
//                                    let loginRequest = try decoder.decode(MainResponse.self, from: data)
////                                   completion(loginRequest)
//                                } catch let error {
//                                    print(error)
////                                    completion(nil)
//                                }
////                    let json = JSON(value)
////                    if  response.response?.statusCode == 200{
////                        Baas().saveJSON(json: json, key: "queriedUserDetails")
////                        handler(true,json, nil)
////                    }else{
////                        handler(false,json, nil)
////                    }
//                case .failure(let error):
////                    handler(false,[:], error)
//                }
//        }
//    }
    
}
