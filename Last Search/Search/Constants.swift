//
//  Constants.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import Foundation

enum Constants {
    static let searchAlbumCell = "album"
    
    static let albumScopeBarTitle = "Album"
    static let artistScopeBarTitle = "Artist"
    static let trackScopeBarTitle = "Track"
    
    static let albumMethodParam = "album.search"
    static let artistMethodParam = "artist.search"
    static let trackMethodParam = "track.search"
    
    static let albumInfoMethodParam = "album.getInfo"
    static let artisInfotMethodParam = "artist.getInfo"
    static let trackInfoMethodParam = "track.getInfo"
    
    static let APIKEY = "api_key"
    static let FORMAT = "format"
    static let METHOD = "method"
    static let ALBUM = "album"
    static let ARTIST = "artist"
    static let TRACK = "track"
    static let jsonFormat = "json"
    
    static let moreInfoVCID = "MoreInfoViewController"
    static let mainStoryBoard = "Main"
}

enum WebAPIConstants {
    static let endpoint = "http://ws.audioscrobbler.com/2.0/"
    static let lastAPIKey = "a104c21f30ec50b78b1b23edaaeef31b"
}

