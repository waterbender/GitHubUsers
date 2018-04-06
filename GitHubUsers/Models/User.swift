//
//  User.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/5/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit


struct User {

    //String, URL, Bool and Date conform to Codable.
    var login: String
    var id: Int
    var avatarUrl: URL
    var gravatarId: String
    var url: URL
    var htmlUrl: URL
    var followersUrl: URL
    var followingUrl: String
    var gistsUrl: String
    var starredUrl: String
    var subscriptionsUrl: URL
    var organizationsUrl: URL
    var reposUrl: URL
    var eventsUrl: String
    var receivedEventsUrl: URL
    var type: String
    var siteAdmin: Bool
    
    enum CodingKeys: String, CodingKey
    {
        case login
        case id
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
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
        case type
        case siteAdmin = "site_admin"
    }
}

extension User: Encodable {
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(login, forKey: .login)
        try container.encode(id, forKey: .id)
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
    }
}

extension User: Decodable {
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let login: String = try values.decode(String.self, forKey: .login)
        let id: Int = try values.decode(Int.self, forKey: .id)
        let avatarUrl: URL = try values.decode(URL.self, forKey: .avatarUrl)
        let url: URL = try values.decode(URL.self, forKey: .url)
        let gravatarId: String = try values.decode(String.self, forKey: .url)
        let htmlUrl: URL = try values.decode(URL.self, forKey: .htmlUrl)
        let followersUrl: URL = try values.decode(URL.self, forKey: .followersUrl)
        let followingUrl: String = try values.decode(String.self, forKey: .followingUrl)
        let gistsUrl: String = try values.decode(String.self, forKey: .gistsUrl)
        let starredUrl: String = try values.decode(String.self, forKey: .starredUrl)
        let subscriptionsUrl: URL = try values.decode(URL.self, forKey: .subscriptionsUrl)
        let organizationsUrl: URL = try values.decode(URL.self, forKey: .organizationsUrl)
        let reposUrl: URL = try values.decode(URL.self, forKey: .reposUrl)
        let eventsUrl: String = try values.decode(String.self, forKey: .eventsUrl)
        let receivedEventsUrl: URL = try values.decode(URL.self, forKey: .receivedEventsUrl)
        let type: String = try values.decode(String.self, forKey: .type)
        let siteAdmin: Bool = try values.decode(Bool.self, forKey: .siteAdmin)

        self.init(login: login, id: id, avatarUrl: avatarUrl, gravatarId: gravatarId, url: url, htmlUrl: htmlUrl, followersUrl: followersUrl, followingUrl: followingUrl, gistsUrl: gistsUrl, starredUrl: starredUrl, subscriptionsUrl: subscriptionsUrl, organizationsUrl: organizationsUrl, reposUrl: reposUrl, eventsUrl: eventsUrl, receivedEventsUrl: receivedEventsUrl, type: type, siteAdmin: siteAdmin)
    }
}
