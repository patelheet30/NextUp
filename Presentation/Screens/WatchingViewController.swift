//
//  WatchingViewController.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation
import UIKit

// MARK: Struct for the displayed data in Home menu
struct WatchingItemDisplayData {
    let id: UUID
    let title: String
    let overview: String?
    let posterPath: String?
    let episodeCode: String?
    let releaseDate: Date?
    let progress: Double
}

class WatchingViewController: UIViewController {
    
    // MARK: Properties for the Watching Views
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    
    private var watchingItems: [WatchingItemDisplayData] = []
    
    private let cellIdentifier = "WatchingCell"
    
    // MARK: Initialisation for the watching section
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Watching"
        
        setupCollectionView()
        loadDummyData()
    }
    
    // MARK: Setting up the Collection View
    private func setupCollectionView() {
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(WatchingCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: Dummy data to see Watching section layout
    private func loadDummyData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let item1 = WatchingItemDisplayData(
            id: UUID(),
            title: "Stranger Things",
            overview: "A love letter to the '80s classics that captivated a generation...",
            posterPath: nil,
            episodeCode: "S04E03",
            releaseDate: formatter.date(from: "2022-05-27"),
            progress: 0.65
        )
        
        let item2 = WatchingItemDisplayData(
            id: UUID(),
            title: "The Batman",
            overview: "In his second year of fighting crime...",
            posterPath: nil,
            episodeCode: nil, // Movie
            releaseDate: formatter.date(from: "2022-03-04"),
            progress: 0.30
        )
        
        let item3 = WatchingItemDisplayData(
            id: UUID(),
            title: "The Last of Us",
            overview: "Twenty years after a fungal outbreak...",
            posterPath: nil,
            episodeCode: "S01E05",
            releaseDate: formatter.date(from: "2023-01-15"),
            progress: 0.85
        )
        
        let item4 = WatchingItemDisplayData(
            id: UUID(),
            title: "Stranger Things",
            overview: "A love letter to the '80s classics that captivated a generation...",
            posterPath: nil,
            episodeCode: "S04E04",
            releaseDate: formatter.date(from: "2022-05-27"),
            progress: 0.10
        )
        
        let item5 = WatchingItemDisplayData(
            id: UUID(),
            title: "Everything Everywhere All at Once",
            overview: "A middle-aged Chinese immigrant...",
            posterPath: nil,
            episodeCode: nil, // Movie
            releaseDate: formatter.date(from: "2022-03-25"),
            progress: 0.50
        )
        
        self.watchingItems = [item1, item2, item3, item4, item5]
        self.collectionView.reloadData()
    }
}

// MARK: Extensions
extension WatchingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchingItems.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? WatchingCell else {
            return UICollectionViewCell()
        }
        
        let item = watchingItems[indexPath.item]
        cell.configure(with: item)
        
        return cell
    }
}

extension WatchingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalPadding: CGFloat = 20 + 20
        let width = collectionView.bounds.width - horizontalPadding
        
        let height: CGFloat = AppConfiguration.UI.blockHeight
        
        return CGSize(width: width, height: height)
    }
}
