//
//  AlbumViewModel.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/5/20.
//

import Foundation

class AlbumViewModel {
    
    private var album: Album
    let service: NetworkServiceProtocol
    
    init(album: Album, service: NetworkServiceProtocol = NetworkService()) {
        self.album = album
        self.service = service
    }
    
    var name: String {
        return album.name ?? "Unknown"
    }
    
    var artist: String {
        return album.artistName ?? "Unknown"
    }
    
    var albumArtURL: URL? {
        guard let urlString = album.artworkUrl100 else { return nil }
        return URL(string: urlString)
    }
    
    var url: URL? {
        guard let urlString = album.url else { return nil }
        return URL(string: urlString)
    }
    
    var copyright: String {
        return album.copyright ?? "Unknown"
    }
    
    var releaseDate: String {
        let releaseDateString = album.releaseDate ?? "Unknown"
        return "Release date: " + releaseDateString
    }
    
    var genre: String {
        let genreString = album.genresString ?? "Unknown"
        return "Genre: " + genreString
    }
    
}
