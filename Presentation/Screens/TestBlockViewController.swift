//
//  TestBlockViewController.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import UIKit

class TestBlockViewController: UIViewController {
    private let blockView = BlockView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        blockView.configure(title: "Stranger Things", overview: nil, posterPath: nil, progress: 0.65, episodeCode: "S04E03", releaseDate: Date())
        view.addSubview(blockView)
        
        blockView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blockView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            blockView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            blockView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
