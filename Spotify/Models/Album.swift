//
//  Album.swift
//  Spotify
//
//  Created by Ramon Amini on 2/14/22.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable  {
    let album_type: String
    let available_markets: [String]
    let id: String
    let images: [SpotifyImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}

struct SpotifyImage: Codable  {
    let url: String
}

struct Artist: Codable  {
    let external_urls: [String: String]
    let name: String
    let type: String
    let id: String
}

