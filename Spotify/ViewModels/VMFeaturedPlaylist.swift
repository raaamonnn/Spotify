//
//  VMFeaturedPlaylist.swift
//  Spotify
//
//  Created by Ramon Amini on 2/18/22.
//

import Foundation

struct VMFeaturedPlaylist {
    let name: String
    let artworkUrl: URL?
    let creatorName: String
    
    init(featuredPlaylist: Playlist) {
        name = featuredPlaylist.name
        artworkUrl = URL(string: featuredPlaylist.images.first?.url ?? "")
        creatorName = featuredPlaylist.owner.display_name
    }
}

