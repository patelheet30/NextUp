//
//  WatchingCell.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation
import UIKit

class WatchingCell: UICollectionViewCell {
    // MARK: Block View for each Watching Cell
    private lazy var blockView: BlockView = {
        let view = BlockView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        NSLayoutConstraint.activate([
            blockView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blockView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with data: WatchingItemDisplayData) {
        blockView.configure(title: data.title, overview: data.overview, posterPath: data.posterPath, progress: data.progress, episodeCode: data.episodeCode, releaseDate: data.releaseDate)
    }
}
