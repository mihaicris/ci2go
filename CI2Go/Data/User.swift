//
//  User.swift
//  CI2Go
//
//  Created by Atsushi Nagase on 2018/06/17.
//  Copyright © 2018 LittleApps Inc. All rights reserved.
//

import Foundation

struct User: Decodable {
    let login: String
    let avatarURL: URL?
    let name: String?
    let vcs: VCS?
    let id: Int? // swiftlint:disable:this identifier_name
    let pusherID: String?

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case name
        case vcs = "vcs_type"
        case pusherID = "pusher_id"
        case id // swiftlint:disable:this identifier_name
    }

    var pusherChannelName: String? {
        guard let pusherID = pusherID else { return nil }
        return "private-\(pusherID)"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decode(String.self, forKey: .login)
        avatarURL = try? values.decode(URL.self, forKey: .avatarURL)
        name = try? values.decode(String.self, forKey: .name)
        vcs = try? values.decode(VCS.self, forKey: .vcs)
        pusherID = try? values.decode(String.self, forKey: .pusherID)
        id = try? values.decode(Int.self, forKey: .id)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.login == rhs.login
    }
}
