//
//  AudioTrack.swift
//  Spotify
//
//  Created by Ramon Amini on 2/10/22.
//

import Foundation

struct AudioTrack: Codable {
    let album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let name: String
}

struct TrackResponse: Codable {
    let items: [AudioTrack]
}
