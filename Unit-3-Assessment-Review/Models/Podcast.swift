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
    
    static func getPodcastData(from searchQuery: String, completionHandler: @escaping (Result<[Podcast],AppError>) -> () ) {
        let url = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchQuery)"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                print(url)
            case .success(let data):
                do {
                    let podcastData = try JSONDecoder().decode(PodcastModel.self, from: data)
                    completionHandler(.success(podcastData.results))
                  
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}


struct Podcast: Codable {
    let trackName: String
    let artworkUrl100: String
    let artworkUrl600: String?
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
