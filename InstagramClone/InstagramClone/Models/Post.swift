//
//  Post.swift
//  InstagramClone
//
//  Created by vfa on 6/29/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation

struct Post {
    let user: User
    let imageUrl: String
    let caption: String

    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
