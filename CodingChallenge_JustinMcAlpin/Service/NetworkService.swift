//
//  NetworkService.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/5/20.
//

import UIKit

protocol NetworkServiceProtocol {
    func downloadAlbums(_ success: @escaping ([AlbumViewModel]) -> Void,
                        _ failure: @escaping () -> Void)
    func downloadImage(from url: URL,
                       _ success: @escaping (UIImage) -> Void,
                       _ failure: @escaping () -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    private var imageCache = [URL:UIImage]()
    
    func downloadAlbums(_ success: @escaping ([AlbumViewModel]) -> Void,
                        _ failure: @escaping () -> Void) {
        guard let url = URL(string: urlString) else {
            failure()
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                failure()
                return
            }
            let decoder = JSONDecoder()
            do {
                let parsed = try decoder.decode(DataModel.self, from: data)
                let viewModels = parsed.feed.results.map { AlbumViewModel(album: $0) }
                success(viewModels)
            } catch {
                failure()
            }
        }.resume()
    }
    
    func downloadImage(from url: URL,
                       _ success: @escaping (UIImage) -> Void,
                       _ failure: @escaping () -> Void) {
        if let cachedImage = imageCache[url] {
            success(cachedImage)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let image = UIImage(data: data) else {
                failure()
                return
            }
            self.imageCache[url] = image
            success(image)
        }.resume()
    }
    
}

