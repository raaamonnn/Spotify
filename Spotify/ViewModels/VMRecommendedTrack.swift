//
//  VMRecommendedTrack.swift
//  Spotify
//
//  Created by Ramon Amini on 2/18/22.
//

import Foundation

struct VMRecommendedTrack {
    let name: String
    let artistName: String
    let artworkUrl: URL?
    
    init(recommendedTrack: AudioTrack) {
        name = recommendedTrack.name
        artworkUrl = URL(string: recommendedTrack.album?.images.first?.url ?? "")
        artistName = recommendedTrack.name
    }
}
