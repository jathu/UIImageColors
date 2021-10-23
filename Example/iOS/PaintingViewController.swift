//
//  PaintingViewController.swift
//  iOS
//
//  Created by Felix Herrmann on 14.10.21.
//

import UIKit

final class PaintingViewController: UIViewController {
    
    
    // MARK: - Properties
    
    let painting: Painting
    
    private let imageView = UIImageView()
    
    
    // MARK: - Initializers
    
    init(painting: Painting) {
        self.painting = painting
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    // MARK: - Setup
    
    private func setupView() {
        imageView.image = painting.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            imageView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 160),
            imageView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -140)
        ])
    }
}
