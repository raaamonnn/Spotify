//
//  VMNewReleases.swift
//  Spotify
//
//  Created by Ramon Amini on 2/17/22.
//

import Foundation

struct VMNewReleases {
    let name: String
    let artworkUrl: URL?
    let numberOfTracks: Int
    let artistName: String
    
    init(album: Album) {
        self.name = album.name
        self.artworkUrl = URL(string: album.images.first?.url ?? "")
        self.numberOfTracks = album.total_tracks
        self.artistName = album.artists.first?.name ?? "-"
    }
}
