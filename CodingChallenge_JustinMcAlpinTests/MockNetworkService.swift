//
//  MockNetworkService.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/5/20.
//

import Foundation
@testable import CodingChallenge_JustinMcAlpin

class MockNetworkService: NetworkServiceProtocol {
    
    func downloadJSON(from url: URL, _ completion: @escaping (Data?) -> Void) {
        guard let path = Bundle(for: CodingChallenge_JustinMcAlpinTests.self).path(forResource: "top_albums", ofType: "json") else {
            fatalError()
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            completion(data)
        }
        catch {
            fatalError(error.localizedDescription)
        }
        
    }
}

class MockFailingNetworkService: NetworkServiceProtocol {
    
    func downloadJSON(from url: URL, _ completion: @escaping (Data?) -> Void) {
        completion(nil)
    }
}

