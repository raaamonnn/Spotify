//
//  VMPlaylistHeader.swift
//  Spotify
//
//  Created by Ramon Amini on 2/20/22.
//

import Foundation

struct VMPlaylistHeader {
    let name: String
    let playlistCover: URL?
    let creatorName: String
    let playlistDescription: String
    
    init(playlist: Playlist) {
        name = playlist.name
        playlistCover = URL(string: playlist.images.first?.url ?? "")
        creatorName = playlist.owner.display_name
        playlistDescription = playlist.description
    }
}
