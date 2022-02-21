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

struct AlbumDetails: Codable {
    let album_type: String
    let total_tracks: Int
    let available_markets: [String]
    let external_urls: [String: String]
    let href, id: String
    let images: [SpotifyImage]
    let name, release_date, release_date_precision: String
    let type, uri: String
    let artists: [Artist]
    let tracks: TrackResponse
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

