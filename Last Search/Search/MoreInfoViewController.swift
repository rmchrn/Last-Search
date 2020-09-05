//
//  MoreInfoViewController.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import UIKit

fileprivate enum SelectedType {
    case track
    case album
    case artist
}

class MoreInfoViewController: UIViewController {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var listeners: UILabel!
    @IBOutlet weak var playcountLabel: UILabel!
    
    var albumSelected: String?
    var trackSelected: String?
    var artistSelected: String?
    
    private var selectedType: SelectedType = .album
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSelectedType()
        getMoreInfo()
    }
    /**
     get more info API call based on the inputs injected to MoreInfoVC
     */
    func getMoreInfo() {
        let params = createGetCallParams()
        NetworkCallManager.shared.getCall(withURL: WebAPIConstants.endpoint, urlParams: params) { [unowned self] (data) in
            let jsonDecoder = JSONDecoder()
            do {
                switch self.selectedType {
                case .album:
                    let albumInfo = try jsonDecoder.decode(AlbumInfo.self, from: data)
                    self.updateAlbumInfo(albumInfo: albumInfo)
                case .artist:
                    let artistInfo = try jsonDecoder.decode(ArtistInfo.self, from: data)
                    self.updateArtistInfo(artistInfo: artistInfo)
                case .track:
                    let trackInfo = try jsonDecoder.decode(TrackInfo.self, from: data)
                    self.updateTrackInfo(trackInfo: trackInfo)
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    private func updateAlbumInfo(albumInfo: AlbumInfo) {
        let album = albumInfo.album
        let image = album?.image?.first(where: { (image) -> Bool in
            image.size == Size.extralarge
        })
        if let image = image {
            self.headerImage.setRemoteImage(url: URL(string: image.text ?? ""))
        } else {
            self.headerImage.isHidden = true
        }
        self.title = album?.name
        nameLabel.text = album?.name
        publishedLabel.text = album?.wiki?.published
        listeners.text = album?.listeners
        playcountLabel.text = album?.playcount
    }
    
    private func updateArtistInfo(artistInfo: ArtistInfo) {
        let artist = artistInfo.artist
        let image = artist?.image.first(where: { (image) -> Bool in
            image.size == Size.extralarge
        })
        if let image = image {
            self.headerImage.setRemoteImage(url: URL(string: image.text ?? ""))
        } else {
            self.headerImage.isHidden = true
        }
        self.title = artist?.name
        nameLabel.text = artist?.name
        publishedLabel.text = artist?.bio?.published
        listeners.text = artist?.stats?.listeners
        playcountLabel.text = artist?.stats?.playcount
    }
    
    private func updateTrackInfo(trackInfo: TrackInfo) {
        let track = trackInfo.track
        let image = track?.album?.image?.first(where: { (image) -> Bool in
            image.size == Size.extralarge
        })
        if let image = image {
            self.headerImage.setRemoteImage(url: URL(string: image.text ?? ""))
        } else {
            self.headerImage.isHidden = true
        }
        nameLabel.text = track?.name
        self.title = track?.name
        publishedLabel.text = track?.wiki?.published
        listeners.text = track?.listeners
        playcountLabel.text = track?.playcount
    }
    
    private func updateSelectedType() {
        if let _ = artistSelected, let _ = albumSelected {
            selectedType = .album
        } else if let _ = artistSelected, let _ = trackSelected {
            selectedType = .track
        } else {
            selectedType = .artist
        }
    }
    /**
    it will create the get call parameters in a robust way
    */
    private func createGetCallParams() -> [String:String] {
        var params = [String:String]()
        params[Constants.APIKEY] = WebAPIConstants.lastAPIKey
        params[Constants.FORMAT] = Constants.jsonFormat
        switch selectedType {
        case .album:
            params[Constants.METHOD] = Constants.albumInfoMethodParam
            params[Constants.ALBUM] = albumSelected ?? ""
            params[Constants.ARTIST] = artistSelected ?? ""
        case .artist:
            params[Constants.METHOD] = Constants.artisInfotMethodParam
            params[Constants.ARTIST] = artistSelected ?? ""
        case .track:
            params[Constants.METHOD] = Constants.trackInfoMethodParam
            params[Constants.TRACK] = trackSelected ?? ""
            params[Constants.ARTIST] = artistSelected ?? ""
        }
        return params
    }
    
}
