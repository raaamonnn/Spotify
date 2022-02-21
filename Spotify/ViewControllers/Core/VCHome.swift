//
//  VCHome.swift
//  Spotify
//
//  Created by Ramon Amini on 2/10/22.
//

import UIKit

class VCHome: UIViewController {
    enum SectionType: Int, CaseIterable {
        case newReleases = 0
        case featuredPlaylists = 1
        case recommendedTracks = 2
    }
    
    let appEnvironment: AppEnvironment
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
        return VCHome.createSectionLayout(index: SectionType(rawValue: sectionIndex) ?? SectionType(rawValue: 0)!)
    }))
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }()
    
    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
        super.init(nibName: nil, bundle: .none)
    }
    
    private static func createSectionLayout(index: SectionType) -> NSCollectionLayoutSection {
        
        switch index {
        case .newReleases:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                                widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
            
            //Group
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(360)),
                subitem: item,
                count: 1
            )
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(360)),
            subitem: horizontalGroup,
            count: 3
            )
            
            //Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 32, trailing: 16)
            return section
            
        case .featuredPlaylists:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                                widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1))
            )
            
            //Group
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(175),
                    heightDimension: .fractionalHeight(0.5)),
                subitem: item,
                count: 1
            )
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(175),
                heightDimension: .fractionalHeight(0.5)),
            subitem: horizontalGroup,
            count: 2
            )
            
            //Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            section.interGroupSpacing = 2
            return section
            
        case .recommendedTracks:
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
            return section
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
//        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
        view.addSubview(spinner)
        
        appEnvironment.repoSpotify.loadData { [weak self] in
            self?.spinner.removeFromSuperview()
            self?.configureCollectionView()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spinner.frame = view.bounds
        collectionView.frame = view.bounds
    }
    
    private func configureCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CVCNewRelease.self, forCellWithReuseIdentifier: CVCNewRelease.identifier)
        collectionView.register(CVCFeaturedPlaylist.self, forCellWithReuseIdentifier: CVCFeaturedPlaylist.identifier)
        collectionView.register(CVCRecommendedTrack.self, forCellWithReuseIdentifier: CVCRecommendedTrack.identifier)
//        collectionView.register(CRVHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CRVHeader.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    @objc func didTapSettings() {
        let vc = VCSettings(appEnvironment: appEnvironment)
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension VCHome: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SectionType(rawValue: section)
        switch sectionType {
        case .newReleases:
            return appEnvironment.repoSpotify.newReleases?.albums.items.count ?? 0
        case .featuredPlaylists:
            return appEnvironment.repoSpotify.featuredPlaylists?.playlists.items.count ?? 0
        case .recommendedTracks:
            return appEnvironment.repoSpotify.recommendations?.tracks.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sectionType = SectionType(rawValue: indexPath.section)
        
        switch sectionType {
        case .newReleases:
            guard let album = appEnvironment.repoSpotify.newReleases?.albums.items[indexPath.row] else { return }
            let vc = VCAlbum(album: album, appEnvironment: appEnvironment)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .featuredPlaylists:
            guard let playlist = appEnvironment.repoSpotify.featuredPlaylists?.playlists.items[indexPath.row] else { return }
            let vc = VCPlaylist(playlist: playlist, appEnvironment: appEnvironment)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .recommendedTracks:
            break
        default:
            break
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (appEnvironment.repoSpotify.recommendations == nil) {
            return UICollectionViewCell()
        }
        
        let sectionType = SectionType(rawValue: indexPath.section)
        switch sectionType {
        case .newReleases:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCNewRelease.identifier, for: indexPath) as? CVCNewRelease else {
                return UICollectionViewCell()
            }
            cell.configure(with: VMNewReleases(album: (appEnvironment.repoSpotify.newReleases?.albums.items[indexPath.row])!))
            return cell
        case .featuredPlaylists:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCFeaturedPlaylist.identifier, for: indexPath) as? CVCFeaturedPlaylist else {
                return UICollectionViewCell()
            }
            cell.configure(with: VMFeaturedPlaylist(featuredPlaylist: (appEnvironment.repoSpotify.featuredPlaylists?.playlists.items[indexPath.row])!))
            return cell
        case .recommendedTracks:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCRecommendedTrack.identifier, for: indexPath) as? CVCRecommendedTrack else {
                return UICollectionViewCell()
            }
            cell.configure(with: VMRecommendedTrack(recommendedTrack: (appEnvironment.repoSpotify.recommendations?.tracks[indexPath.row])!))
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
////        if indexPath.section == 1 {
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CRVHeader.identifier, for: indexPath) as! CRVHeader
//            header.configure(header: "Featured Playlists")
//            return header
////        }
////        return UICollectionReusableView()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.size.width, height: 200)
//    }
}
