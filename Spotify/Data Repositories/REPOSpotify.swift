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
    var newReleases: NewReleasesResponse?
    var featuredPlaylists: FeaturedPlaylistsResponse?
    var recommendedGenre: RecommendedGenres?
    var recommendations: Recommendations?
    
    init(svcSpotify: SVCSpotify) {
        self.svcSpotify = svcSpotify
        svcSpotify.getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let model):
                self?.userProfile = model
            case .failure(let error):
            print("[-] Error Getting Current User Profile \(error.localizedDescription)")
            }
        }
        svcSpotify.getNewReleases { [weak self] result in
            switch result {
            case .success(let model):
                self?.newReleases = model
            case .failure(let error):
            print("[-] Error Getting New Releases \(error.localizedDescription)")
            }
        }
        svcSpotify.getFeaturedPlaylists { [weak self] result in
            switch result {
            case .success(let model):
                self?.featuredPlaylists = model
            case .failure(let error):
            print("[-] Error Getting Featured Playlists  \(error.localizedDescription)")
            }
        }
        
        svcSpotify.getRecommendedGenre { [weak self] result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                svcSpotify.getRecommendations(genres: seeds) { result in
                    switch result {
                    case .success(let model):
                        self?.recommendations = model
                    case .failure(let error):
                    print("[-] Error Getting Recommendations \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
            print("[-] Error Getting Recommended Genres  \(error.localizedDescription)")
            }
        }
    }
}
