//
//  ViewController.swift
//  macOS
//
//  Created by Felix Herrmann on 14.10.21.
//

import AppKit

final class ViewController: NSViewController {
    
    
    // MARK: - Properties
    
    private let scrollView = NSScrollView(frame: NSRect(x: 0, y: 0, width: 800, height: 630))
    private let collectionView = NSCollectionView()
    
    private lazy var dataSource: NSCollectionViewDiffableDataSource<String, Painting> = {
        return NSCollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, painting in
            let item = collectionView.makeItem(withIdentifier: .painting, for: indexPath) as? PaintingItem
            item?.image = painting.image
            item?.mainLabel.text = painting.name
            item?.secondaryLabel.text = painting.artist
            item?.detailLabel.text = "• \(painting.year)"
            return item
        }
    }()
    
    
    // MARK: - ViewController
    
    override func loadView() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(PaintingItem.self, forItemWithIdentifier: .painting)
        
        scrollView.documentView = collectionView
        view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applySnapshot()
    }
    
    
    // MARK: - CollectionViewLayout
    
    private func createLayout() -> NSCollectionViewLayout {
        let layout = NSCollectionViewCompositionalLayout { _, environment in
            let itemsPerWidth = CGFloat(Int(environment.container.effectiveContentSize.width / 300))
            let fractionalWidth = 1 / (itemsPerWidth < 1 ? 1 : itemsPerWidth)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalWidth), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layout
    }
    
    
    // MARK: - DiffableDataSource
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, Painting>()
        snapshot.appendSections(["main"])
        snapshot.appendItems(Painting.examples, toSection: "main")
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


// MARK: - NSUserInterfaceItemIdentifier + painting

extension NSUserInterfaceItemIdentifier {
    static let painting = NSUserInterfaceItemIdentifier("painting")
}
