//
//  FavoritePodcast.swift
//  Unit-3-Assessment-Review
//
//  Created by Anthony Gonzalez on 9/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

struct FavoritePodcast: Codable {
    let trackId: Int
    let favoritedBy: String
    let collectionName: String
    let artworkUrl600: String
}
