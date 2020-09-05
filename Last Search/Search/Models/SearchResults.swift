//
//  SearchResults.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import Foundation

// MARK: - SearchResults
struct SearchResults: Codable {
    let results: Results?
}

// MARK: - Results
struct Results: Codable {
    let opensearchQuery: OpensearchQuery
    let opensearchTotalResults, opensearchStartIndex, opensearchItemsPerPage: String
    let albummatches: Albummatches?
    let artistmatches: Artistmatches?
    let trackmatches: Trackmatches?
    let attr: Attr

    enum CodingKeys: String, CodingKey {
        case opensearchQuery = "opensearch:Query"
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case albummatches, artistmatches, trackmatches
        case attr = "@attr"
    }
}

// MARK: - Artistmatches
struct Artistmatches: Codable {
    let artist: [Artist]
}

// MARK: - Albummatches
struct Albummatches: Codable {
    let album: [Album]
}


// MARK: - Trackmatches
struct Trackmatches: Codable {
    let track: [Track]
}


// MARK: - Image
struct Image: Codable {
    let text: String?
    let size: Size?

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

enum Size: String, Codable {
    case extralarge = "extralarge"
    case large = "large"
    case medium = "medium"
    case small = "small"
    case mega = "mega"
    case empty = ""
}

// MARK: - Attr
struct Attr: Codable {
    let attrFor: String?

    enum CodingKeys: String, CodingKey {
        case attrFor = "for"
    }
}

// MARK: - OpensearchQuery
struct OpensearchQuery: Codable {
    let text, role, searchTerms, startPage: String?

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case role, searchTerms, startPage
    }
}
