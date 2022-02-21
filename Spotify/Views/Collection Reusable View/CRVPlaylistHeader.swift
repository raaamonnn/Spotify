//
//  CRVPlaylistHeader.swift
//  Spotify
//
//  Created by Ramon Amini on 2/20/22.
//

import UIKit
import SDWebImage

protocol CRVPlaylistHeaderDelegate: AnyObject {
    func CRVPlaylistHeaderDelegateDidTapPlayAll(_ header: CRVPlaylistHeader)
}
final class CRVPlaylistHeader: UICollectionReusableView {
    static let identifier = "CRVPlaylistHeader"
    weak var delegate: CRVPlaylistHeaderDelegate?
    
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
    
    private let playlistDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playlistOwner: UILabel = {
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
        addSubview(playlistDescription)
        addSubview(playlistOwner)
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

            playlistDescription.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            playlistDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playlistDescription.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -8),

            playlistOwner.topAnchor.constraint(equalTo: playlistDescription.bottomAnchor, constant: 4),
            playlistOwner.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playlistOwner.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -8),

            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            playButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc private func didTapPlayAll() {
        delegate?.CRVPlaylistHeaderDelegateDidTapPlayAll(self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with viewModel: VMPlaylistHeader) {
        playlistImage.sd_setImage(with: viewModel.playlistCover, completed: nil)
        name.text = viewModel.name
        playlistDescription.text = viewModel.playlistDescription
        playlistOwner.text = viewModel.creatorName
    }
}
