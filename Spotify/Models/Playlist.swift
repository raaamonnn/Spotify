//
//  Playlist.swift
//  Spotify
//
//  Created by Ramon Amini on 2/10/22.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [SpotifyImage]
    let name: String
    let owner: User
}

struct PlaylistDetails: Codable {
    let collaborative: Bool
    let description: String?
    let external_urls: [String: String]
    let followers: Followers
    let href, id: String
    let images: [SpotifyImage]
    let name: String
    let owner: User
    let tracks: PlaylistTrackResponse
}

struct PlaylistTrackResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}

struct Followers: Codable {
    let total: Int
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let followers: Followers?
    let id: String
}
