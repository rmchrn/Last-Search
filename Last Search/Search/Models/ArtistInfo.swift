//
//  ArtistInfo.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import Foundation

// MARK: - ArtistInfo
struct ArtistInfo: Codable {
    let artist: ArtistInfoArtist
}

// MARK: - ArtistInfoArtist
struct ArtistInfoArtist: Codable {
    let name, mbid: String
    let url: String
    let image: [Image]
    let streamable, ontour: String
    let stats: Stats
    let tags: Toptags
    let bio: Bio
}

// MARK: - Bio
struct Bio: Codable {
    let links: Links
    let published, summary, content: String
}

// MARK: - Links
struct Links: Codable {
    let link: Link
}

// MARK: - Link
struct Link: Codable {
    let text, rel: String
    let href: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case rel, href
    }
}

// MARK: - Stats
struct Stats: Codable {
    let listeners, playcount: String
}
