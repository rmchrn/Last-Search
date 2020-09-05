//
//  Album.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import Foundation

// MARK: - Album
struct Album: Codable {
    let name, artist: String
    let url: String
    let image: [Image]
    let streamable, mbid: String
}

