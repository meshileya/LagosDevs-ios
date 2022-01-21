//
//  UserInfoDto.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation

struct UserInfoDto: Codable {

    let login: String?
    let id: Int?
    let nodeId: String?
    let avatarUrl: String?
    let gravatarId: String?
    let url: String?
    let htmlUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let starredUrl: String?
    let subscriptionsUrl: String?
    let organizationsUrl: String?
    let reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: String?
    let siteAdmin: Bool
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
    let createdAt: String?
    let updatedAt: String?

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
        case name = "name"
        case company = "company"
        case blog = "blog"
        case location = "location"
        case email = "email"
        case hireable = "hireable"
        case bio = "bio"
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers = "followers"
        case following = "following"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        nodeId = try values.decodeIfPresent(String.self, forKey: .nodeId)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        gravatarId = try values.decodeIfPresent(String.self, forKey: .gravatarId)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        followersUrl = try values.decodeIfPresent(String.self, forKey: .followersUrl)
        followingUrl = try values.decodeIfPresent(String.self, forKey: .followingUrl)
        gistsUrl = try values.decodeIfPresent(String.self, forKey: .gistsUrl)
        starredUrl = try values.decodeIfPresent(String.self, forKey: .starredUrl)
        subscriptionsUrl = try values.decodeIfPresent(String.self, forKey: .subscriptionsUrl)
        organizationsUrl = try values.decodeIfPresent(String.self, forKey: .organizationsUrl)
        reposUrl = try values.decodeIfPresent(String.self, forKey: .reposUrl)
        eventsUrl = try values.decodeIfPresent(String.self, forKey: .eventsUrl)
        receivedEventsUrl = try values.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        siteAdmin = try values.decodeIfPresent(Bool.self, forKey: .siteAdmin) ?? false
        name = try values.decodeIfPresent(String.self, forKey: .name)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        blog = try values.decodeIfPresent(String.self, forKey: .blog)
        location = try values.decodeIfPresent(String.self, forKey: .location) // TODO: Add code for decoding `location`, It was null at the time of model creation.
        email = try values.decodeIfPresent(String.self, forKey: .email) // TODO: Add code for decoding `email`, It was null at the time of model creation.
        hireable = try values.decodeIfPresent(Bool.self, forKey: .hireable) // TODO: Add code for decoding `hireable`, It was null at the time of model creation.
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        twitterUsername = try values.decodeIfPresent(String.self, forKey: .twitterUsername) // TODO: Add code for decoding `twitterUsername`, It was null at the time of model creation.
        publicRepos = try values.decodeIfPresent(Int.self, forKey: .publicRepos)
        publicGists = try values.decodeIfPresent(Int.self, forKey: .publicGists)
        followers = try values.decodeIfPresent(Int.self, forKey: .followers)
        following = try values.decodeIfPresent(Int.self, forKey: .following)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
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
        try container.encode(name, forKey: .name)
        try container.encode(company, forKey: .company)
        try container.encode(blog, forKey: .blog)
        // TODO: Add code for encoding `location`, It was null at the time of model creation.
        // TODO: Add code for encoding `email`, It was null at the time of model creation.
        // TODO: Add code for encoding `hireable`, It was null at the time of model creation.
        try container.encode(bio, forKey: .bio)
        // TODO: Add code for encoding `twitterUsername`, It was null at the time of model creation.
        try container.encode(publicRepos, forKey: .publicRepos)
        try container.encode(publicGists, forKey: .publicGists)
        try container.encode(followers, forKey: .followers)
        try container.encode(following, forKey: .following)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }

}
