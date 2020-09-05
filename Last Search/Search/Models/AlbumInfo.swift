//
//  AlbumInfo.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//
import Foundation

// MARK: - AlbumInfo
struct AlbumInfo: Codable {
    let album: AlbumDetails?
}

// MARK: - Album
struct AlbumDetails: Codable {
    let name: String?
    let artist: String?
    let mbid: String?
    let url: String?
    let image: [Image]?
    let listeners, playcount: String?
    let tracks: Tracks?
    let tags: Toptags?
    let wiki: Wiki?
    let title: String?
}

// MARK: - Tracks
struct Tracks: Codable {
    let track: [TrackArtist]?
}

// MARK: - Track
struct TrackArtist: Codable {
    let name: String?
    let artist: ArtistTrack?
    let url: String?
    let listeners: String?
    let image: [Image]?
    let mbid: String?
}

struct ArtistTrack: Codable {
    let name: String?
    let mbid: String?
    let url: String?
}

// MARK: - ArtistClass
struct ArtistClass: Codable {
    let name: String?
    let mbid: String?
    let url: String?
}


