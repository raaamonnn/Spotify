//
//  VMAlbumTrack.swift
//  Spotify
//
//  Created by Ramon Amini on 2/21/22.
//

import Foundation

struct VMAlbumTrack {
    let name: String
    var artistName = ""
    
    init(track: AudioTrack) {
        name = track.name
        for artist in track.artists {
            self.artistName.append(artist.name + " • ")
        }
    }
}
