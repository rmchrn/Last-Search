//
//  TrackInfo.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import Foundation

// MARK: - TrackInfo
struct TrackInfo: Codable {
    let track: TrackDetails?
}

// MARK: - Track
struct TrackDetails: Codable {
    let name, mbid: String?
    let url: String?
    let duration: String?
    let streamable: StreamableDetails?
    let listeners, playcount: String?
    let artist: ArtistDetails?
    let album: AlbumDetails?
    let toptags: Toptags?
    let wiki: Wiki?
}

// MARK: - Artist
struct ArtistDetails: Codable {
    let name, mbid: String?
    let url: String?
}

// MARK: - Streamable
struct StreamableDetails: Codable {
    let text, fulltrack: String?

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case fulltrack
    }
}

// MARK: - Toptags
struct Toptags: Codable {
    let tag: [Tag]?
}

// MARK: - Tag
struct Tag: Codable {
    let name: String?
    let url: String?
}

// MARK: - Wiki
struct Wiki: Codable {
    let published, summary, content: String?
}
