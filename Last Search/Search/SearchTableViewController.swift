//
//  SearchTableViewController.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    var results: SearchResults? {
        didSet {
            if let _ = self.results {
                self.albums = results?.results.albummatches.album
            }
        }
    }
    
    var albums: [Album]? {
        didSet {
            if let _ = self.albums {
                self.tableView.reloadData()
            }
        }
    }
    
    var selectedScopeBarTittle: String = "Album"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchControllerSetup()
    }
    
    private func searchControllerSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Albums"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = [Constants.albumScopeBarTitle, Constants.trackScopeBarTitle, Constants.artistScopeBarTitle]
        searchController.searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedScopeBarTittle {
        case Constants.albumScopeBarTitle:
            return albums?.count ?? 0
        case Constants.artistScopeBarTitle:
            return albums?.count ?? 0
        case Constants.trackScopeBarTitle:
            return albums?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedScopeBarTittle {
        case Constants.albumScopeBarTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchAlbumCell, for: indexPath) as! AlbumTableViewCell
            if let album = albums?[indexPath.row] {
                cell.updateData(withAlbum: album)
            }
            return cell
        case Constants.artistScopeBarTitle:
            break
        case Constants.trackScopeBarTitle:
            break
        default:
            break
        }
        return UITableViewCell()
    }
    
    
    
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if let title = searchBar.scopeButtonTitles?[selectedScope] {
            selectedScopeBarTittle = title
        }
        searchBar.placeholder = "Search \(selectedScopeBarTittle)"
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchString = searchController.searchBar.text
        var params = [String:String]()
        params["method"] = "album.search"
        params["album"] = searchString
        params["api_key"] = WebAPIConstants.lastAPIKey
        params["format"] = Constants.jsonFormat
        NetworkCallManager.shared.getCall(withURL: WebAPIConstants.endpoint, urlParams: params) { [unowned self] (data) in
            do {
                self.results = try JSONDecoder().decode(SearchResults.self, from: data)
                self.tableView.reloadData()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
    }
}
