//
//  VMAlbumHeader.swift
//  Spotify
//
//  Created by Ramon Amini on 2/21/22.
//

import Foundation

struct VMAlbumHeader {
    let name: String
    let playlistCover: URL?
    var artistNames = ""
    let date: String
    
    init(album: Album) {
        name = album.name
        playlistCover = URL(string: album.images.first?.url ?? "")
        for artist in album.artists {
            artistNames.append(artist.name + " • ")
        }
        date = album.release_date.formattedDate()
    }
}
