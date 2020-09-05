//
//  Artist.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import Foundation

// MARK: - Artist
struct Artist: Codable {
    let name, listeners, mbid: String
    let url: String
    let streamable: String
    let image: [Image]
}
