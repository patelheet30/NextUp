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

struct StackGroup {
    let showTitle: String
    let items: [WatchingItemDisplayData]
    var isExpanded: Bool = false
    
    var topItem: WatchingItemDisplayData {
        return items[0]
    }
    
    var stackCount: Int {
        return items.count
    }
    
    var id: UUID {
        return topItem.id
    }
}

enum DisplayItem {
    case single(WatchingItemDisplayData)
    case stack(StackGroup)
}

class WatchingViewController: UIViewController {
    
    // MARK: Properties for the Watching Views
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()
    private var expandedStackInfo: [UUID: (stackGroup: StackGroup, firstItemIndex: Int)] = [:]
    
    private var watchingItems: [WatchingItemDisplayData] = []
    private var displayItems: [DisplayItem] = []
    
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
        
        let item6 = WatchingItemDisplayData(
            id: UUID(),
            title: "Stranger Things",
            overview: "A love letter to the '80s classics that captivated a generation...",
            posterPath: nil,
            episodeCode: "S04E05",
            releaseDate: formatter.date(from: "2022-05-27"),
            progress: 0.85
        )
        
        self.watchingItems = [item1, item2, item3, item4, item5, item6]
        self.organiseItemsForDisplay()
    }
    
    // MARK: Organising the Displayed Items
    private func organiseItemsForDisplay() {
        let movies = watchingItems.filter { $0.episodeCode == nil }
        let series = watchingItems.filter { $0.episodeCode != nil }
        
        let groupedSeries = Dictionary(grouping: series, by: {$0.title})
        
        var finalItems: [DisplayItem] = []
        
        for movie in movies {
            finalItems.append(.single(movie))
        }
        
        for (title, episodes) in groupedSeries {
            if episodes.count == 1 {
                if let episode = episodes.first {
                    finalItems.append(.single(episode))
                }
            } else {
                let stack = StackGroup(showTitle: title, items: episodes, isExpanded: false)
                finalItems.append(.stack(stack))
            }
        }
        
        finalItems.sort { item1, item2 in
            let date1: Date?
            let date2: Date?
            
            switch item1 {
            case .single(let data):
                date1 = data.releaseDate
            case .stack(let group):
                date1 = group.topItem.releaseDate
            }
            
            switch item2 {
            case .single(let data):
                date2 = data.releaseDate
            case .stack(let group):
                date2 = group.topItem.releaseDate
            }
            
            guard let d1 = date1 else { return false }
            guard let d2 = date2 else { return true }
            
            return d1 > d2
        }
        
        self.displayItems = finalItems
        self.collectionView.reloadData()
    }
    
    // MARK: Toggle Stack feature
    private func toggleStack(at indexPath: IndexPath) {
        guard case .stack(var stackGroup) = displayItems[indexPath.item] else { return }
        
        if stackGroup.isExpanded {
            collapseStack(stackGroup: &stackGroup, at: indexPath)
        } else {
            expandStack(stackGroup: &stackGroup, at: indexPath)
        }
    }
    
    // MARK: Expanding Stack
    private func expandStack(stackGroup: inout StackGroup, at indexPath: IndexPath) {
        let itemsToInsert = stackGroup.items.map { DisplayItem.single($0) }
        
        stackGroup.isExpanded = true
        
        expandedStackInfo[stackGroup.id] = (stackGroup, indexPath.item)
        
        collectionView.performBatchUpdates({
            displayItems[indexPath.item] = itemsToInsert[0]
            
            for i in 1..<itemsToInsert.count {
                let insertPosition = indexPath.item + i
                displayItems.insert(itemsToInsert[i], at: insertPosition)
            }
            
            collectionView.reloadItems(at: [indexPath])
            
            let indexPathsToInsert = (1..<itemsToInsert.count).map { i in
                IndexPath(item: indexPath.item + i, section: 0)
            }
            collectionView.insertItems(at: indexPathsToInsert)
            
        }, completion: nil)
    }
    
    // MARK: Closing Stack
    private func collapseStack(stackGroup: inout StackGroup, at indexPath: IndexPath) {
        let countToRemove = stackGroup.items.count - 1
        
        stackGroup.isExpanded = false
        
        expandedStackInfo.removeValue(forKey: stackGroup.id)
        
        collectionView.performBatchUpdates({
            displayItems[indexPath.item] = .stack(stackGroup)
            
            for _ in 1...countToRemove {
                displayItems.remove(at: indexPath.item + 1)
            }
            
            collectionView.reloadItems(at: [indexPath])
            
            let indexPathsToRemove = (1...countToRemove).map { i in
                IndexPath(item: indexPath.item + i, section: 0)
            }
            collectionView.deleteItems(at: indexPathsToRemove)
            
        }, completion: nil)
    }
    
    // MARK: Finding blocks part of Stacks
    private func findExpandedStack(containing item: WatchingItemDisplayData) -> (StackGroup, Int)? {
        for (stackId, info) in expandedStackInfo {
            if item.title == info.stackGroup.showTitle {
                return (info.stackGroup, info.firstItemIndex)
            }
        }
        return nil
    }
    
}

// MARK: Extensions
extension WatchingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayItems.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? WatchingCell else {
            return UICollectionViewCell()
        }
        
        let displayItem = displayItems[indexPath.item]
        
        switch displayItem {
        case .single(let item):
            cell.configure(with: item, isStack: false, stackCount: 0, stackItems: nil)
        case .stack(let group):
            cell.configure(with: group.topItem, isStack: true, stackCount: group.stackCount, stackItems: group.isExpanded ? nil : group.items)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let displayItem = displayItems[indexPath.item]
        
        switch displayItem {
        case .stack(_):
            toggleStack(at: indexPath)
        case .single(let item):
            if let (stackGroup, firstItemIndex) = findExpandedStack(containing: item) {
                let stackIndexPath = IndexPath(item: firstItemIndex, section: 0)
                var mutableStack = stackGroup
                collapseStack(stackGroup: &mutableStack, at: stackIndexPath)
            }
        }
    }
}

extension WatchingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalPadding: CGFloat = 40
        let width = collectionView.bounds.width - horizontalPadding
        
        let displayItem = displayItems[indexPath.item]
        var height: CGFloat = AppConfiguration.UI.blockHeight
        
        if case .stack(let group) = displayItem, !group.isExpanded {
            let visibleLayers = min(group.stackCount, 3)
            let extraHeight = CGFloat(visibleLayers - 2) * AppConfiguration.UI.stackOffset
            
            height += extraHeight
        }
        
        
        return CGSize(width: width, height: height)
    }
}

