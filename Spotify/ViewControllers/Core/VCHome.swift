//
//  VCHome.swift
//  Spotify
//
//  Created by Ramon Amini on 2/10/22.
//

import UIKit

class VCHome: UIViewController {
    let appEnvironment: AppEnvironment
    private var collectionView: UICollectionView?
    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
        super.init(nibName: nil, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
//        let layout = UICollectionViewCompositionalLayout { sectionIndex, phoneType -> NSCollectionLayoutSection? in
//
//
//        }
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
//    private func createSectionLayout(index: Int) -> NSCollectionLayoutSection
    @objc func didTapSettings() {
        let vc = VCSettings(appEnvironment: appEnvironment)
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
    }
}
