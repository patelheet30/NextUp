//
//  BlockView.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import UIKit

class BlockView: UIView {
    // MARK: Properties for Media Content
    private var mediaTitle: String?
    private var mediaOverview: String?
    private var posterPath: String?
    private var progressValue: Double?
    private var episodeCode: String?
    private var releaseDate: Date?
    
    private var isStack: Bool = false
    private var stackCount: Int = 0
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy"
        return df
    }()
    
    // MARK: Properties for UI Subviews
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        // Placeholder color to view
        iv.backgroundColor = .systemGray5
        return iv
    }()
    
    private lazy var blurOverlayView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var episodeCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .tertiaryLabel
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressBarContainerView: ProgressBarView = {
        let view = ProgressBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.9)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private lazy var stackBadgeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: Setup UIView
    private func setupView() {
        self.layer.cornerRadius = AppConfiguration.UI.cornerRadius
        self.clipsToBounds = true
        self.backgroundColor = .systemBackground
        
        addSubview(backgroundImageView)
        addSubview(blurOverlayView)
        
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(episodeCodeLabel)
        contentStackView.addArrangedSubview(releaseDateLabel)
        contentStackView.addArrangedSubview(progressBarContainerView)
        
        stackBadgeView.addSubview(stackBadgeLabel)
        addSubview(stackBadgeView)
        
        // MARK: Auto Layout constraints
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            blurOverlayView.topAnchor.constraint(equalTo: topAnchor),
            blurOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            progressBarContainerView.heightAnchor.constraint(equalToConstant: 6),
            progressBarContainerView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            
            stackBadgeLabel.topAnchor.constraint(equalTo: stackBadgeView.topAnchor, constant: 4),
            stackBadgeLabel.leadingAnchor.constraint(equalTo: stackBadgeView.leadingAnchor, constant: 8),
            stackBadgeLabel.trailingAnchor.constraint(equalTo: stackBadgeView.trailingAnchor, constant: -8),
            stackBadgeLabel.bottomAnchor.constraint(equalTo: stackBadgeView.bottomAnchor, constant: -4),
            
            stackBadgeView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackBadgeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackBadgeView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: Configuration method
    func configure(title: String?, overview: String?, posterPath: String?, progress: Double?, episodeCode: String?, releaseDate: Date?, isStack: Bool = false, stackCount: Int = 0) {
        self.mediaTitle = title
        self.mediaOverview = overview
        self.posterPath = posterPath
        self.progressValue = progress
        self.episodeCode = episodeCode
        self.releaseDate = releaseDate
        
        titleLabel.text = title
        
        if let code = episodeCode, !code.isEmpty {
            episodeCodeLabel.text = code
            episodeCodeLabel.isHidden = false
        } else {
            episodeCodeLabel.isHidden = true
        }
        
        if let date = releaseDate {
            releaseDateLabel.text = BlockView.dateFormatter.string(from: date)
            releaseDateLabel.isHidden = false
        } else {
            releaseDateLabel.isHidden = true
        }
        
        if let progress = progress {
            progressBarContainerView.isHidden = false
            progressBarContainerView.setProgress(progress, animated: false)
            
        } else {
            progressBarContainerView.isHidden = true
        }
        
        if let path = posterPath {
            // Logic for posterpath will go here once Kingfisher is setup
        }
        
        self.isStack = isStack
        self.stackCount = stackCount
        
        if isStack && stackCount > 1 {
            stackBadgeView.isHidden = false
            
            let episodeText = stackCount == 1 ? "episode" : "episodes"
            stackBadgeLabel.text = "\(stackCount) \(episodeText)"
        } else {
            stackBadgeView.isHidden = true
        }
    }
    
}
