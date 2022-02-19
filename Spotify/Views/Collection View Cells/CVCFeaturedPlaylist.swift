//
//  CVCFeaturedPlaylist.swift
//  Spotify
//
//  Created by Ramon Amini on 2/17/22.
//

import UIKit

class CVCFeaturedPlaylist: UICollectionViewCell {
    static let identifier = "CVCFeaturedPlaylist"
    
    private let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let playlistName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let creatorName: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.addSubview(artworkImageView)
        contentView.addSubview(playlistName)
        contentView.addSubview(creatorName)
        
        NSLayoutConstraint.activate([
            artworkImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, constant: -26),
            artworkImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -26),
            artworkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            artworkImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            artworkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            
            playlistName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playlistName.topAnchor.constraint(equalTo: artworkImageView.bottomAnchor, constant: 8),
            playlistName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            
            creatorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            creatorName.topAnchor.constraint(equalTo: playlistName.bottomAnchor, constant: 2),
            creatorName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artworkImageView.image = nil
        playlistName.text = nil
        creatorName.text = nil
    }
    
    func configure(with viewModel: VMFeaturedPlaylist) {
        artworkImageView.sd_setImage(with: viewModel.artworkUrl, completed: nil)
        playlistName.text = viewModel.name
        creatorName.text = viewModel.creatorName
    }
}
