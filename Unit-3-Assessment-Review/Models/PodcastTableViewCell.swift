//
//  podcastTableViewCell.swift
//  Unit-3-Assessment-Review
//
//  Created by Anthony Gonzalez on 9/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var podcastName: UILabel!
    @IBOutlet weak var podcastGenre: UILabel!
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastArtist: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func configureCell(from podcast: Podcast) {
        self.podcastName.text = podcast.trackName
        self.podcastArtist.text = podcast.artistName
        
        if let primaryGenre = podcast.primaryGenreName {
            self.podcastGenre.text = primaryGenre
        } else {
            self.podcastGenre.text = "No Genre"
        }
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        ImageHelper.shared.getImage(urlStr: podcast.artworkUrl600) { (result) in
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
    }
     
    

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
