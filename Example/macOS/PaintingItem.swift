//
//  PaintingItem.swift
//  macOS
//
//  Created by Felix Herrmann on 22.10.21.
//

import AppKit
import UIImageColors

final class PaintingItem: NSCollectionViewItem {
    
    
    // MARK: - Properties
    
    private let _imageView = NSView()
    let mainLabel = NSLabel()
    let secondaryLabel = NSLabel()
    let detailLabel = NSLabel()
    
    var image: NSImage? {
        didSet {
            _imageView.layer?.contents = image
            image?.getColors { colors in
                if let colors = colors {
                    self.view.layer?.backgroundColor = colors.background.cgColor
                    self.mainLabel.textColor = colors.primary
                    self.secondaryLabel.textColor = colors.secondary
                    self.detailLabel.textColor = colors.detail
                } else {
                    self.view.layer?.backgroundColor = nil
                    self.mainLabel.textColor = .labelColor
                    self.secondaryLabel.textColor = .labelColor
                    self.detailLabel.textColor = .labelColor
                }
            }
        }
    }
    
    
    // MARK: - ViewController
    
    override func loadView() {
        view = NSView()
        view.autoresizingMask = [.width, .height]
        view.wantsLayer = true
        
        _imageView.layer = CALayer()
        _imageView.layer?.contentsGravity = .resizeAspectFill
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        secondaryLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let layoutGuide = NSLayoutGuide()
        view.addLayoutGuide(layoutGuide)
        
        view.addSubview(_imageView)
        view.addSubview(mainLabel)
        view.addSubview(secondaryLabel)
        view.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            layoutGuide.leadingAnchor.constraint(equalTo: _imageView.trailingAnchor, constant: 20),
            layoutGuide.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            layoutGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            _imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            _imageView.topAnchor.constraint(equalTo: view.topAnchor),
            _imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            _imageView.widthAnchor.constraint(equalTo: _imageView.heightAnchor),
            
            mainLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            mainLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            mainLabel.trailingAnchor.constraint(lessThanOrEqualTo: layoutGuide.trailingAnchor),
            
            secondaryLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            secondaryLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 4),
            secondaryLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            
            detailLabel.leadingAnchor.constraint(equalTo: secondaryLabel.trailingAnchor, constant: 4),
            detailLabel.firstBaselineAnchor.constraint(equalTo: secondaryLabel.firstBaselineAnchor),
            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: layoutGuide.trailingAnchor)
        ])
    }
}
