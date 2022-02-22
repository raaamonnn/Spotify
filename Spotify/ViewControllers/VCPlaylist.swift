//
//  VCPlaylist.swift
//  Spotify
//
//  Created by Ramon Amini on 2/10/22.
//

import UIKit

class VCPlaylist: UIViewController {
    
    private let playlist: Playlist
    private let appEnvironment: AppEnvironment
    private var playlistDetails: PlaylistDetails? = nil
    
    init(playlist: Playlist, appEnvironment: AppEnvironment) {
        self.playlist = playlist
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
        return VCPlaylist.createSectionLayout()
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
        collectionView.register(CVCRecommendedTrack.self, forCellWithReuseIdentifier: CVCRecommendedTrack.identifier)
        collectionView.register(CRVPlaylistHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CRVPlaylistHeader.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        appEnvironment.repoSpotify.getPlaylistDetails(for: playlist) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.spinner.removeFromSuperview()
                    self?.playlistDetails = model
                    self?.title = self?.playlistDetails?.name
                    self?.configureCollectionView()
                case .failure(let error):
                    print("[-] Error Getting Playlist Details \(error.localizedDescription)")
                    self?.title = "Not Found"
                }
            }
        }
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        // Do any additional setup after loading the view.
    }
    
    @objc private func didTapShare() {
        guard let url = URL(string: playlist.external_urls["spotify"] ?? "") else {
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

extension VCPlaylist: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCRecommendedTrack.identifier, for: indexPath) as? CVCRecommendedTrack else {
            return UICollectionViewCell()
        }
        cell.configure(with: VMRecommendedTrack(recommendedTrack: (playlistDetails?.tracks.items[indexPath.row].track)!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlistDetails?.tracks.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CRVPlaylistHeader.identifier, for: indexPath) as? CRVPlaylistHeader, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        header.configure(with: VMPlaylistHeader(playlist: playlist))
        header.delegate = self
        return header
    }
}

extension VCPlaylist: DidTapPlayAllDelegate {
    func didTapPlayAll(_ header: UICollectionReusableView) {
        print("Clicked Play All")
    }
}
