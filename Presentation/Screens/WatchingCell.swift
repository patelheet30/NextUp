//
//  WatchingCell.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation
import UIKit

class WatchingCell: UICollectionViewCell {
    // MARK: Block/Stack View for each Watching Cell
    private lazy var blockView: BlockView = {
        let view = BlockView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackedContainerView: StackedBlockContainerView = {
        let view = StackedBlockContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    // MARK: Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: Setting and configuring view
    private func setupView() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(blockView)
        contentView.addSubview(stackedContainerView)
        
        NSLayoutConstraint.activate([
            blockView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blockView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackedContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackedContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackedContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackedContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with data: WatchingItemDisplayData, isStack: Bool, stackCount: Int, stackItems: [WatchingItemDisplayData]?) {
        let shouldShowStackedView = (stackItems != nil) && (stackItems!.count > 0)
        
        if shouldShowStackedView {
            blockView.isHidden = true
            stackedContainerView.isHidden = false
            stackedContainerView.configure(with: stackItems!)
        } else {
            blockView.isHidden = false
            stackedContainerView.isHidden = true
            blockView.configure(title: data.title, overview: data.overview, posterPath: data.posterPath, progress: data.progress, episodeCode: data.episodeCode, releaseDate: data.releaseDate, isStack: false, stackCount: 0)
        }
    }
}
