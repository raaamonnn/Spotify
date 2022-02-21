//
//  REPOSpotify.swift
//  Spotify
//
//  Created by Ramon Amini on 2/13/22.
//

import Foundation

final class REPOSpotify {
    private let svcSpotify: SVCSpotify
    var userProfile: UserProfile?
    var newReleases: NewReleasesResponse?
    var featuredPlaylists: FeaturedPlaylistsResponse?
    var recommendedGenre: RecommendedGenres?
    var recommendations: Recommendations?
    
    init(svcSpotify: SVCSpotify) {
        self.svcSpotify = svcSpotify
    }
    
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetails, Error>) -> Void) {
        svcSpotify.getAlbumDetails(for: album) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetails, Error>) -> Void) {
        svcSpotify.getPlaylistDetails(for: playlist) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    public func loadData(completionHandler: @escaping () -> Void) {
        
        let group = DispatchGroup()
        
        group.enter()
        svcSpotify.getCurrentUserProfile { [weak self] result in
            
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                self?.userProfile = model
            case .failure(let error):
            print("[-] Error Getting Current User Profile \(error.localizedDescription)")
            }
        }
        
        group.enter()
        svcSpotify.getNewReleases { [weak self] result in
            
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                self?.newReleases = model
            case .failure(let error):
            print("[-] Error Getting New Releases \(error.localizedDescription)")
            }
        }
            
        group.enter()
        svcSpotify.getFeaturedPlaylists { [weak self] result in
            
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                self?.featuredPlaylists = model
            case .failure(let error):
            print("[-] Error Getting Featured Playlists  \(error.localizedDescription)")
            }
        }
        
        group.enter()
        svcSpotify.getRecommendedGenre { [weak self] result in
            
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                group.enter()
                self?.svcSpotify.getRecommendations(genres: seeds) { result in
                    
                    defer {
                        group.leave()
                    }
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
        
        group.notify(queue: .main) {
            print("[+] Fetched all Spotify Data")
            completionHandler()
        }
    }
}
