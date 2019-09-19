//
//  ViewController.swift
//  Unit-3-Assessment-Review
//
//  Created by Anthony Gonzalez on 9/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class SearchPodcastViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var podcasts = [Podcast]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var searchString = String() {
        didSet {
            loadData()
        }
    }
    //Every time this is set, the data is loaded with the searchString being passed to the PodcastAPIManager.shared.getPodcasts function.
    
    
    private func loadData() {
        PodcastAPIManager.shared.getPodcasts(searchQuery: searchString){ (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let podcastData):
                    self.podcasts = podcastData
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifer = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifer {
            
        case "segueToDetail":
            guard let destVC = segue.destination as? detailViewController else { fatalError("Unexpected segue VC") }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { fatalError("No row selected") }
            let selectedPodcast = podcasts[selectedIndexPath.row]
            
            destVC.currentPodcast = selectedPodcast
           
        default:
            fatalError("unexpected segue identifier")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension SearchPodcastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as! PodcastTableViewCell
        let specificPodcast = podcasts[indexPath.row]
        cell.configureCell(from: specificPodcast)
        return cell
    }
}

extension SearchPodcastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension SearchPodcastViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
