//
//  Podcast.swift
//  Unit-3-Assessment-Review
//
//  Created by Anthony Gonzalez on 9/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation


struct PodcastModel: Codable {
    let results: [Podcast]
}


struct Podcast: Codable {
    let trackName: String
    let trackId: Int
    let artworkUrl100: String
    let artworkUrl600: String
    let genres: [String]
    let artistID: Int?
    let artistName: String
    let primaryGenreName: String?
    let contentAdvisoryRating: ContentAdvisoryRating?

    
    enum ContentAdvisoryRating: String, Codable {
        case clean = "Clean"
        case explicit = "Explicit"
    }
}
