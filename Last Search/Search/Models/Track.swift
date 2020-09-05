//
//  Track.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import Foundation

// MARK: - Track
struct Track: Codable {
    let name, artist: String?
    let url: String
    let streamable: Streamable
    let listeners: String
    let image: [Image]
    let mbid: String
}


enum Streamable: String, Codable {
    case fixme = "FIXME"
}
