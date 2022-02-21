//
//  VCAlbum.swift
//  Spotify
//
//  Created by Ramon Amini on 2/20/22.
//

import UIKit

class VCAlbum: UIViewController {
    init(album: Album, appEnvironment: AppEnvironment) {
        self.album = album
        self.appEnvironment = appEnvironment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let album: Album
    private var albumDetails: AlbumDetails?
    private let appEnvironment: AppEnvironment
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appEnvironment.repoSpotify.getAlbumDetails(for: album) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.albumDetails = model
                    self?.title = self?.albumDetails?.name
                case .failure(let error):
                    print("[-] Error Getting Album Details \(error.localizedDescription)")
                    self?.title = "Not Found"
                }
            }
        }
        
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
}
