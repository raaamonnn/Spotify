//
//  CRVHeader.swift
//  Spotify
//
//  Created by Ramon Amini on 2/18/22.
//

import UIKit

class CRVHeader: UICollectionReusableView {
    static let identifier = "CRVHeader"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(header: String) {
        label.text = header
    }
}
