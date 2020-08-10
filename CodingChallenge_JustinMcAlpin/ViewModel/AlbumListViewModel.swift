//
//  AlbumListViewModel.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/5/20.
//

import Foundation

class AlbumListViewModel {
    
    private let service: NetworkServiceProtocol
    private(set) var viewModels: [AlbumViewModel] = []
    
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    func downloadAlbums(_ success: @escaping () -> Void,
                        _ failure: @escaping () -> Void) {
        service.downloadAlbums({ (viewModels) in
            self.viewModels = viewModels
            success()
        }, failure)
    }
}
