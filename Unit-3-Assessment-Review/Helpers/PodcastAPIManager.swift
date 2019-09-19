//
//  PodcastAPIManager.swift
//  Unit-3-Assessment-Review
//
//  Created by Anthony Gonzalez on 9/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

class PodcastAPIManager {
    private init() {}
    
    static let shared = PodcastAPIManager()
    
    func getPodcasts(searchQuery: String, completionHandler: @escaping (Result<[Podcast], AppError>) -> Void) {
        let urlStr = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchQuery)"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let podcastInfo = try JSONDecoder().decode(PodcastModel.self, from: data)
                    completionHandler(.success(podcastInfo.results))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    
    func postPodcast(podcast: FavoritePodcast, completionHandler: @escaping (Result<Data, AppError>) -> Void) {
//        let podcastWrapper = PodcastModel(results: [podcast])
        guard let encodedData = try? JSONEncoder().encode([podcast]) else {
            fatalError("encoder failed")
        }
        let urlStr = "https://5d82e237c9e3410014070e0c.mockapi.io/favorites"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andHTTPBody: encodedData, andMethod: .post) { (result) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error) :
                completionHandler(.failure(error))
            }
        }
        
    }
}
