//
//  ProgressBarView.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import UIKit

class ProgressBarView: UIView {
    // MARK: Properties
    var progress: Double = 0.0 {
        didSet {
            updateProgressLayer()
        }
    }
    var isInteractive: Bool = false
    
    private let trackLayer = CALayer()
    private let progressLayer = CALayer()
    
    private var trackColor: UIColor {
        return .systemGray5
    }
    
    private var progressColor: UIColor {
        return .tintColor
    }
    
    // MARK: Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    // MARK: Setup and update layers
    private func setupLayers() {
        trackLayer.backgroundColor = trackColor.cgColor
        trackLayer.cornerRadius = 2.0
        layer.addSublayer(trackLayer)
        
        progressLayer.backgroundColor = progressColor.cgColor
        progressLayer.cornerRadius = 2.0
        progressLayer.anchorPoint = CGPoint(x: 0, y: 0)
        layer.addSublayer(progressLayer)
    }
    
    private func updateProgressLayer() {
        let progressWidth = bounds.width * CGFloat(progress)
        
        let newFrame = CGRect(
            x: 0,
            y: 0,
            width: progressWidth,
            height: bounds.height
        )
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.frame = newFrame
        CATransaction.commit()
    }
    
    func setProgress(_ newProgress: Double, animated: Bool) {
        let clampedProgress = min(max(newProgress, 0.0), 1.0)
        self.progress = clampedProgress
        
        let newWidth = bounds.width * CGFloat(clampedProgress)
        let newFrame = CGRect(x: 0, y: 0, width: newWidth, height: bounds.height)
        
        if animated {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.3)
            progressLayer.frame = newFrame
            CATransaction.commit()
        } else {
            progressLayer.frame = newFrame
        }
    }
    
    // MARK: Layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackLayer.frame = bounds
        updateProgressLayer()
    }
}
