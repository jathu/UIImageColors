//
//  ViewController.swift
//  Example
//
//  Created by Felix Herrmann on 10.10.21.
//

import UIKit
import UIImageColors

final class ViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private let mainLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let detailLabel = UILabel()
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private var currentIndex: Int = 0 {
        didSet {
            if currentIndex < Painting.examples.startIndex {
                currentIndex = Painting.examples.endIndex - 1
            } else if currentIndex > Painting.examples.endIndex - 1 {
                currentIndex = Painting.examples.startIndex
            }
        }
    }
    
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        setupPageViewController()
    }
    
    
    // MARK: - Setup
    
    private func setupLabels() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.numberOfLines = 2
        mainLabel.font = .systemFont(ofSize: 25, weight: .regular)
        
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.font = .systemFont(ofSize: 20, weight: .regular)
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        view.addSubview(mainLabel)
        view.addSubview(secondaryLabel)
        view.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            mainLabel.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 72),
            mainLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.readableContentGuide.trailingAnchor, constant: -20),
            
            secondaryLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            secondaryLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.readableContentGuide.trailingAnchor, constant: -20),
            secondaryLabel.bottomAnchor.constraint(equalTo: detailLabel.topAnchor, constant: -4),
            
            detailLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.readableContentGuide.trailingAnchor, constant: -20),
            detailLabel.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -92)
        ])
    }
    
    private func setupPageViewController() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let firstPaintingViewController = PaintingViewController(painting: .examples[currentIndex])
        pageViewController.setViewControllers([firstPaintingViewController], direction: .forward, animated: false)
        updateColors(from: firstPaintingViewController)
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        view.addSubview(pageViewController.view)
        
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    // MARK: - Methods
    
    private func updateColors(from paintingViewController: PaintingViewController) {
        paintingViewController.painting.image.getColors { colors in
            UIView.animate(withDuration: 0.15) { [self] in
                view.backgroundColor = colors?.background
                
                mainLabel.text = paintingViewController.painting.name
                mainLabel.textColor = colors?.primary
                
                secondaryLabel.text = paintingViewController.painting.artist
                secondaryLabel.textColor = colors?.secondary
                
                detailLabel.text = paintingViewController.painting.year.description
                detailLabel.textColor = colors?.detail
                
                pageViewController.pageControl?.currentPageIndicatorTintColor = colors?.primary
                pageViewController.pageControl?.pageIndicatorTintColor = colors?.secondary
            }
        }
    }
}


// MARK: - ViewController + UIPageViewControllerDataSource

extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let paintingViewController = viewController as? PaintingViewController else { return nil }
        guard let index = Painting.examples.firstIndex(of: paintingViewController.painting) else { return nil }
        currentIndex = index - 1
        return PaintingViewController(painting: .examples[currentIndex])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let paintingViewController = viewController as? PaintingViewController else { return nil }
        guard let index = Painting.examples.firstIndex(of: paintingViewController.painting) else { return nil }
        currentIndex = index + 1
        return PaintingViewController(painting: .examples[currentIndex])
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return Painting.examples.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentIndex
    }
}


// MARK: - ViewController + UIPageViewControllerDelegate

extension ViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let paintingViewController = pageViewController.viewControllers?.first as? PaintingViewController else { return }
        updateColors(from: paintingViewController)
    }
}
