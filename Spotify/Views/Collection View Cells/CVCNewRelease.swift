//
//  CVCNewRelease.swift
//  Spotify
//
//  Created by Ramon Amini on 2/17/22.
//

import UIKit
import SDWebImage

class CVCNewRelease: UICollectionViewCell {
    static let identifier = "CVCNewRelease"
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let albumName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumName)
        
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
        NSLayoutConstraint.activate([
            albumCoverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -16),
            albumCoverImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, constant: -16),
            albumCoverImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            albumCoverImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            albumCoverImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            albumName.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 8),
            albumName.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            albumName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 8),
            artistNameLabel.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 2),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            numberOfTracksLabel.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 8),
            numberOfTracksLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 2),
            numberOfTracksLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
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
        albumCoverImageView.image = nil
        albumName.text = nil
        numberOfTracksLabel.text = nil
        artistNameLabel.text = nil
    }
    
    func configure(with viewModel: VMNewReleases) {
        albumCoverImageView.sd_setImage(with: viewModel.artworkUrl, completed: nil)
        albumName.text = viewModel.name
        numberOfTracksLabel.text = "Songs - \(viewModel.numberOfTracks)"
        artistNameLabel.text = viewModel.artistName
    }
}
