//
//  NetworkService.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/10/20.
//

import Foundation

protocol NetworkServiceProtocol {
    func downloadJSON(from url: URL, _ completion: @escaping (Data?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func downloadJSON(from url: URL, _ completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            completion(data)
        }.resume()
    }
    
}

