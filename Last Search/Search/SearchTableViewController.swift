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
                updateDataSources()
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
    
    var artists: [Artist]? {
        didSet {
            if let _ = self.artists {
                self.tableView.reloadData()
            }
        }
    }
    
    var songs: [Track]? {
        didSet {
            if let _ = self.songs {
                self.tableView.reloadData()
            }
        }
    }
    
    var selectedScopeBarTittle: String = Constants.ALBUM
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchControllerSetup()
    }
    
    /**
     it will do initial setup for search view controller
     */
    private func searchControllerSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Albums"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = [Constants.albumScopeBarTitle, Constants.trackScopeBarTitle, Constants.artistScopeBarTitle]
        searchController.searchBar.delegate = self
    }
    
    /**
     it will update the data sources need for the table view
     */
    fileprivate func updateDataSources() {
        switch selectedScopeBarTittle.lowercased() {
        case Constants.albumScopeBarTitle.lowercased():
            self.albums = results?.results?.albummatches?.album
            self.artists = nil
            self.songs = nil
        case Constants.artistScopeBarTitle.lowercased():
            self.artists = results?.results?.artistmatches?.artist
            self.albums = nil
            self.songs = nil
        case Constants.trackScopeBarTitle.lowercased():
            self.songs = results?.results?.trackmatches?.track
            self.albums = nil
            self.artists = nil
        default:
            break
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedScopeBarTittle.lowercased() {
        case Constants.albumScopeBarTitle.lowercased():
            return albums?.count ?? 0
        case Constants.artistScopeBarTitle.lowercased():
            return artists?.count ?? 0
        case Constants.trackScopeBarTitle.lowercased():
            return songs?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchAlbumCell, for: indexPath) as! AlbumTableViewCell
        if (albums?.count ?? 0) > 0 {
            if let album = albums?[indexPath.row] {
                cell.updateData(withAlbum: album)
            }
        }
        if (artists?.count ?? 0) > 0 {
            if let artist = artists?[indexPath.row] {
                cell.updateData(withAlbum: artist)
            }
        }
        if (songs?.count ?? 0) > 0 {
            if let song = songs?[indexPath.row] {
                cell.updateData(withAlbum: song)
            }
        }
        return cell
    }
    
    /**
     it helps user to navigate to the more info view controller for track, artist and Album
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: Constants.mainStoryBoard, bundle: nil)
        let moreInfoVC = sb.instantiateViewController(withIdentifier: Constants.moreInfoVCID) as! MoreInfoViewController
        if (albums?.count ?? 0) > 0 {
            if let album = albums?[indexPath.row] {
                moreInfoVC.albumSelected = album.name
                moreInfoVC.artistSelected = album.artist
            }
        }
        if (artists?.count ?? 0) > 0 {
            if let artist = artists?[indexPath.row] {
                moreInfoVC.artistSelected = artist.name
            }
        }
        if (songs?.count ?? 0) > 0 {
            if let song = songs?[indexPath.row] {
                moreInfoVC.artistSelected = song.artist
                moreInfoVC.trackSelected = song.name
            }
        }
        self.navigationController?.pushViewController(moreInfoVC, animated: true)
    }
    
    /**
    it will create the get call parameters in a robust way
    */
    func createGetCallParams(withSearchkey key:String?) -> [String:String] {
        var params = [String:String]()
        params[Constants.APIKEY] = WebAPIConstants.lastAPIKey
        params[Constants.FORMAT] = Constants.jsonFormat
        switch selectedScopeBarTittle.lowercased() {
        case Constants.albumScopeBarTitle.lowercased():
            params[Constants.METHOD] = Constants.albumMethodParam
            params[Constants.ALBUM] = key
        case Constants.artistScopeBarTitle.lowercased():
            params[Constants.METHOD] = Constants.artistMethodParam
            params[Constants.ARTIST] = key
        case Constants.trackScopeBarTitle.lowercased():
            params[Constants.METHOD] = Constants.trackMethodParam
            params[Constants.TRACK] = key
        default:
            break
        }
        return params
    }
    
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    /**
     it will be called when we change the scope selection
     */
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if let title = searchBar.scopeButtonTitles?[selectedScope] {
            selectedScopeBarTittle = title
        }
        searchBar.placeholder = "Search \(selectedScopeBarTittle)"
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getSearchResults(_ params: [String : String], completion: (()->Void)? = nil) {
        NetworkCallManager.shared.getCall(withURL: WebAPIConstants.endpoint, urlParams: params) { [unowned self] (data) in
            do {
                self.results = try JSONDecoder().decode(SearchResults.self, from: data)
                if let completion = completion {
                    completion()
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    /**
     Network call being made when user taps on search button
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchString = searchController.searchBar.text
        let params = createGetCallParams(withSearchkey: searchString)
        getSearchResults(params)
    }
}
