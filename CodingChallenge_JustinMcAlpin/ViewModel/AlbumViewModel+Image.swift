//
//  AlbumViewModel+Image.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/5/20.
//

import UIKit

extension AlbumViewModel {
    
    func downloadImage(_ success: @escaping (UIImage) -> Void,
                       _ failure: (() -> Void)? = nil) {
        guard let url = albumArtURL else {
            failure?()
            return
        }
        let failureWrapper: () -> Void = {
            failure?()
        }
        service.downloadImage(from: url, success, failureWrapper)
    }
    
}
