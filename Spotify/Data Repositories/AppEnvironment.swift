//
//  AppEnvironment.swift
//  Spotify
//
//  Created by Ramon Amini on 2/10/22.
//

import Foundation

final class AppEnvironment {
    let repoAuth: REPOAuth
    let repoSpotify: REPOSpotify
    init(repoAuth: REPOAuth, repoSpotify: REPOSpotify) {
        self.repoAuth = repoAuth
        self.repoSpotify = repoSpotify
    }
}
