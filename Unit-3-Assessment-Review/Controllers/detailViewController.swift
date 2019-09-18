//
//  detailViewController.swift
//  Unit-3-Assessment-Review
//
//  Created by Anthony Gonzalez on 9/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var podcastName: UILabel!
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastGenre: UILabel!
    @IBOutlet weak var podcastArtist: UILabel!
    @IBOutlet weak var podcastContentAdvisoryRating: UILabel!
    
    var currentPodcastExplicitness = String()
    var currentPodcast: Podcast!
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
    }
    
    
    func configureLayout() {
        podcastName.text = currentPodcast.trackName
        podcastArtist.text = currentPodcast.artistName
        podcastGenre.text = currentPodcast.genres.joinedStringFromArray.replacingOccurrences(of: ", Podcasts", with: "")
        currentPodcastExplicitness = currentPodcast.contentAdvisoryRating.map { $0.rawValue } ?? "clean"
        
    }
    
    func checkExplicitness () {
        if currentPodcastExplicitness == "Clean" {
            podcastContentAdvisoryRating.isHidden = true
        } else {
            podcastContentAdvisoryRating.isHidden = false
        }
    }
    
    
    
    private func loadImage(from Podcast: Podcast) {
        if let podcastImage = Podcast.artworkUrl600 {
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            ImageHelper.shared.fetchImage(urlString: podcastImage) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                        self.podcastImage.image = imageFromOnline
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                    }
                }
            }
        } else {
            self.podcastImage.image = #imageLiteral(resourceName: "noimageavailable")
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        loadImage(from: currentPodcast)
        print(currentPodcastExplicitness)
        checkExplicitness()
    }
}
