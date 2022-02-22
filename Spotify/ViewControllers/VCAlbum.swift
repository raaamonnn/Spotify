//
//  VCAlbum.swift
//  Spotify
//
//  Created by Ramon Amini on 2/20/22.
//

import UIKit

class VCAlbum: UIViewController {
    private let album: Album
    private var albumDetails: AlbumDetails?
    private let appEnvironment: AppEnvironment
    
    init(album: Album, appEnvironment: AppEnvironment) {
        self.album = album
        self.appEnvironment = appEnvironment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }()
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
        return VCAlbum.createSectionLayout()
    }))
    
    private static func createSectionLayout() -> NSCollectionLayoutSection {
        //Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                            widthDimension: .fractionalWidth(1),
                                            heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(60)),
            subitem: item,
            count: 1
        )
        
        //Section
        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 32, trailing: 16)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
        ]
        return section
    }

    private func configureCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CVCAlbumTrack.self, forCellWithReuseIdentifier: CVCAlbumTrack.identifier)
        collectionView.register(CRVAlbumHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CRVAlbumHeader.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appEnvironment.repoSpotify.getAlbumDetails(for: album) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.albumDetails = model
                    self?.configureCollectionView()
                    self?.title = self?.albumDetails?.name
                case .failure(let error):
                    print("[-] Error Getting Album Details \(error.localizedDescription)")
                    self?.title = "Not Found"
                }
            }
        }
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    @objc private func didTapShare() {
        guard let url = URL(string: albumDetails?.external_urls["spotify"] ?? "") else {
            return
        }
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spinner.frame = view.bounds
        collectionView.frame = view.bounds
    }
}

extension VCAlbum: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumDetails?.tracks.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCAlbumTrack.identifier, for: indexPath) as? CVCAlbumTrack else {
            return UICollectionViewCell()
        }
        cell.configure(with: VMAlbumTrack(track: (albumDetails?.tracks.items[indexPath.row])!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CRVAlbumHeader.identifier, for: indexPath) as? CRVAlbumHeader, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        header.configure(with: VMAlbumHeader(album: album))
        header.delegate = self
        return header
    }
    
}

extension VCAlbum: DidTapPlayAllDelegate {
    func didTapPlayAll(_ header: UICollectionReusableView) {
        print("Clicked Play All")
    }
}
