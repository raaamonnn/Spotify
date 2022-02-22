//
//  CRVAlbumHeader.swift
//  Spotify
//
//  Created by Ramon Amini on 2/21/22.
//

import UIKit
import SDWebImage

final class CRVAlbumHeader: UICollectionReusableView {
    static let identifier = "CRVPlaylistHeader"
    weak var delegate: DidTapPlayAllDelegate?
    
    let playlistImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playlistDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistImage)
        addSubview(name)
        addSubview(playlistDate)
        addSubview(artistName)
        addSubview(playButton)
        
        playButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            playlistImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            playlistImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            playlistImage.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            playlistImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            name.topAnchor.constraint(equalTo: playlistImage.bottomAnchor, constant: 16),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            playlistDate.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            playlistDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playlistDate.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -8),

            artistName.topAnchor.constraint(equalTo: playlistDate.bottomAnchor, constant: 4),
            artistName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            artistName.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -8),

            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            playButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc private func didTapPlayAll() {
        delegate?.didTapPlayAll(self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with viewModel: VMAlbumHeader) {
        playlistImage.sd_setImage(with: viewModel.playlistCover, completed: nil)
        name.text = viewModel.name
        playlistDate.text = viewModel.date
        artistName.text = viewModel.artistNames
    }
}
