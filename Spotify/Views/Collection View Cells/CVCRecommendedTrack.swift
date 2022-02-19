//
//  CVCRecommendedTrack.swift
//  Spotify
//
//  Created by Ramon Amini on 2/17/22.
//

import UIKit

class CVCRecommendedTrack: UICollectionViewCell {
    static let identifier = "CVCRecommendedTrack"
    
    private let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let trackName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistName: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.addSubview(artworkImageView)
        contentView.addSubview(trackName)
        contentView.addSubview(artistName)
        
        NSLayoutConstraint.activate([
            artworkImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -8),
            artworkImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, constant: -8),
            artworkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            artworkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            artworkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            trackName.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 8),
            trackName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            trackName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            artistName.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 8),
            artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor, constant: 2),
            artistName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
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
        trackName.text = nil
        artistName.text = nil
    }
    
    func configure(with viewModel: VMRecommendedTrack) {
        artworkImageView.sd_setImage(with: viewModel.artworkUrl, completed: nil)
        trackName.text = viewModel.name
        artistName.text = viewModel.artistName
    }
}
