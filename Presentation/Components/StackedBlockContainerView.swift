//
//  StackedBlockContainerView.swift
//  NextUp
//
//  Created by Heet Patel on 18/12/2025.
//

import Foundation
import UIKit

class StackedBlockContainerView: UIView {
    private var blockViews: [BlockView] = []
    private let maxVisibleLayers: Int = 3
    private let layerOffset: CGFloat = AppConfiguration.UI.stackOffset
    
    // MARK: Configuration
    func configure(with items: [WatchingItemDisplayData]) {
        blockViews.forEach { $0.removeFromSuperview() }
        blockViews.removeAll()
        
        let layersToShow = min(items.count, maxVisibleLayers)
        
        for i in (0..<layersToShow).reversed() {
            let blockView = BlockView()
            blockView.translatesAutoresizingMaskIntoConstraints = false
            
            let item = items[i]
            
            addSubview(blockView)
            
            blockView.configure(title: item.title, overview: item.overview, posterPath: item.posterPath, progress: item.progress, episodeCode: item.episodeCode, releaseDate: item.releaseDate)
            
            // MARK: Constraints
            NSLayoutConstraint.activate([
                blockView.leadingAnchor.constraint(equalTo: leadingAnchor),
                blockView.trailingAnchor.constraint(equalTo: trailingAnchor),
                blockView.topAnchor.constraint(equalTo: topAnchor),
                blockView.heightAnchor.constraint(equalToConstant: AppConfiguration.UI.blockHeight)
            ])
            applyLayerEffects(to: blockView, layerIndex: i, totalLayers: layersToShow)
            
            blockViews.append(blockView)
        }
    }
    
    // MARK: Adding effects to layers
    private func applyLayerEffects(to block: BlockView, layerIndex: Int, totalLayers: Int) {
        let yOffset = CGFloat(layerIndex) * layerOffset
        let scale = 1.0 - (CGFloat(layerIndex) * 0.04)
        let opacity = 1.0 - (CGFloat(layerIndex) * 0.15)
        
        block.layer.shadowColor = UIColor.black.cgColor
        block.layer.shadowOffset = CGSize(width: 0, height: 4 + (layerIndex * 2))
        block.layer.shadowRadius = 8
        block.layer.shadowOpacity = Float(0.2 + (CGFloat(layerIndex) * 0.1))
        
        block.transform = CGAffineTransform(scaleX: scale, y: scale)
            .translatedBy(x: 0, y: yOffset / scale)
        block.alpha = opacity
    }
}
