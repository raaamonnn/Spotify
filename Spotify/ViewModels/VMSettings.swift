//
//  VMSettings.swift
//  Spotify
//
//  Created by Ramon Amini on 2/13/22.
//

import Foundation

struct VMSection {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
