//
//  Feed.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/5/20.
//

import Foundation

struct DataModel: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let results: [Album]
}

struct Album: Codable {
    let artistName: String?
    let name: String?
    let copyright: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let genres: [Genre]
    let url: String?
}

extension Album {
    var genresString: String? {
        guard genres.isEmpty == false else {
            return nil
        }
        return genres.first?.name
    }
}

struct Genre: Codable {
    let name: String?
    let genreId: String?
}

