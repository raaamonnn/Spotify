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
        label.textColor = .blue
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(header: String) {
        
        backgroundColor = .red
        label.text = header
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
