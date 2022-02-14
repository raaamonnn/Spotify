//
//  REPOSpotify.swift
//  Spotify
//
//  Created by Ramon Amini on 2/13/22.
//

import Foundation

final class REPOSpotify {
    let svcSpotify: SVCSpotify
    var userProfile: UserProfile?
    init(svcSpotify: SVCSpotify) {
        self.svcSpotify = svcSpotify
        svcSpotify.getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let model):
                self?.userProfile = model
            case .failure(let error):
            print("Error Getting Current User Profile \(error.localizedDescription)")
            }
            
        }
    }
}
