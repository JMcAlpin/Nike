//
//  MockNetworkService.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/5/20.
//

import Foundation
import UIKit
@testable import CodingChallenge_JustinMcAlpin

class MockNetworkService: NetworkServiceProtocol {
    func downloadAlbums(_ success: @escaping ([AlbumViewModel]) -> Void, _ failure: @escaping () -> Void) {
        guard let path = Bundle(for: CodingChallenge_JustinMcAlpinTests.self).path(forResource: "top_albums", ofType: "json") else {
            fatalError()
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let parsed = try decoder.decode(DataModel.self, from: data)
            let viewModels = parsed.feed.results.map { AlbumViewModel(album: $0) }
            success(viewModels)
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func downloadImage(from url: URL, _ success: @escaping (UIImage) -> Void, _ failure: @escaping () -> Void) {
        failure()
    }
    
}

class MockFailingNetworkService: NetworkServiceProtocol {
    func downloadAlbums(_ success: @escaping ([AlbumViewModel]) -> Void, _ failure: @escaping () -> Void) {
        failure()
    }
    
    func downloadImage(from url: URL, _ success: @escaping (UIImage) -> Void, _ failure: @escaping () -> Void) {
        failure()
    }
}

