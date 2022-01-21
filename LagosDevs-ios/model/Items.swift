//
//  Items.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import RealmSwift

class Items: Codable {
    
    @objc dynamic var login: String = ""
    @objc dynamic let id: Int
    @objc dynamic let nodeId: String
    @objc dynamic let avatarUrl: String
    @objc dynamic let gravatarId: String
    @objc dynamic let url: String
    @objc dynamic let htmlUrl: String
    @objc dynamic let followersUrl: String
    @objc dynamic let followingUrl: String
    @objc dynamic let gistsUrl: String
    @objc dynamic let starredUrl: String
    @objc dynamic let subscriptionsUrl: String
    @objc dynamic let organizationsUrl: String
    @objc dynamic let reposUrl: String
    @objc dynamic let eventsUrl: String
    @objc dynamic let receivedEventsUrl: String
    @objc dynamic let type: String
    @objc dynamic let siteAdmin: Bool
    @objc dynamic let score: Int
    
    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url = "url"
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type = "type"
        case siteAdmin = "site_admin"
        case score = "score"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decode(String.self, forKey: .login)
        id = try values.decode(Int.self, forKey: .id)
        nodeId = try values.decode(String.self, forKey: .nodeId)
        avatarUrl = try values.decode(String.self, forKey: .avatarUrl)
        gravatarId = try values.decode(String.self, forKey: .gravatarId)
        url = try values.decode(String.self, forKey: .url)
        htmlUrl = try values.decode(String.self, forKey: .htmlUrl)
        followersUrl = try values.decode(String.self, forKey: .followersUrl)
        followingUrl = try values.decode(String.self, forKey: .followingUrl)
        gistsUrl = try values.decode(String.self, forKey: .gistsUrl)
        starredUrl = try values.decode(String.self, forKey: .starredUrl)
        subscriptionsUrl = try values.decode(String.self, forKey: .subscriptionsUrl)
        organizationsUrl = try values.decode(String.self, forKey: .organizationsUrl)
        reposUrl = try values.decode(String.self, forKey: .reposUrl)
        eventsUrl = try values.decode(String.self, forKey: .eventsUrl)
        receivedEventsUrl = try values.decode(String.self, forKey: .receivedEventsUrl)
        type = try values.decode(String.self, forKey: .type)
        siteAdmin = try values.decode(Bool.self, forKey: .siteAdmin)
        score = try values.decode(Int.self, forKey: .score)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(login, forKey: .login)
        try container.encode(id, forKey: .id)
        try container.encode(nodeId, forKey: .nodeId)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(gravatarId, forKey: .gravatarId)
        try container.encode(url, forKey: .url)
        try container.encode(htmlUrl, forKey: .htmlUrl)
        try container.encode(followersUrl, forKey: .followersUrl)
        try container.encode(followingUrl, forKey: .followingUrl)
        try container.encode(gistsUrl, forKey: .gistsUrl)
        try container.encode(starredUrl, forKey: .starredUrl)
        try container.encode(subscriptionsUrl, forKey: .subscriptionsUrl)
        try container.encode(organizationsUrl, forKey: .organizationsUrl)
        try container.encode(reposUrl, forKey: .reposUrl)
        try container.encode(eventsUrl, forKey: .eventsUrl)
        try container.encode(receivedEventsUrl, forKey: .receivedEventsUrl)
        try container.encode(type, forKey: .type)
        try container.encode(siteAdmin, forKey: .siteAdmin)
        try container.encode(score, forKey: .score)
    }
    
}

class ItemsDto: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    @objc dynamic var gravatarId = ""
    @objc dynamic var avatarurl = ""
}


class FavouritesDto: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    @objc dynamic var gravatarId = ""
    @objc dynamic var avatarurl = ""
}

struct ItemsFavouriteDto{
    let isFavourite: Bool
    let item : ItemsDto
}

