//
//  CVCAlbumTrack.swift
//  Spotify
//
//  Created by Ramon Amini on 2/21/22.
//

import UIKit

class CVCAlbumTrack: UICollectionViewCell {
    static let identifier = "CVCAlbumTrack"

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
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.addSubview(trackName)
        contentView.addSubview(artistName)
        
        NSLayoutConstraint.activate([
            trackName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            trackName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            trackName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            artistName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
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
        trackName.text = nil
        artistName.text = nil
    }
    
    func configure(with viewModel: VMAlbumTrack) {
        trackName.text = viewModel.name
        artistName.text = viewModel.artistName
    }
}
