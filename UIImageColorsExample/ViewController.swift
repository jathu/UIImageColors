//
//  ViewController.swift
//  UIImageColorsExample
//
//  Created by Jathu Satkunarajah on 2017-11-30 - Toronto
//  Copyright © 2017 Jathu Satkunarajah. All rights reserved.
//

import UIKit
import UIImageColors

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let albums: [Album] = [
        Album(albumImage: #imageLiteral(resourceName: "Calvin Klein - Kaws"), albumName: "Calvin Klein", artistName: "Kaws", year: 1999),
        Album(albumImage: #imageLiteral(resourceName: "Cafe Terrace at Night - Vincent Van Gogh"), albumName: "Cafe Terrace at Night", artistName: "Vincent Van Gogh", year: 1888),
        Album(albumImage: #imageLiteral(resourceName: "Woman I - Willem de Kooning"), albumName: "Woman I", artistName: "Willem de Kooning", year: 1952),
        Album(albumImage: #imageLiteral(resourceName: "Skull - Jean-Michel Basquiat"), albumName: "Skull", artistName: "Jean-Michel Basquiat", year: 1981),
        Album(albumImage: #imageLiteral(resourceName: "Les Demoiselles d'Avignon - Picasso"), albumName: "Les Demoiselles d'Avignon", artistName: "Pablo Picasso", year: 1907),
        Album(albumImage: #imageLiteral(resourceName: "Le Reve - Pablo Picasso"), albumName: "Le Rêve", artistName: "Pablo Picasso", year: 1932),
        Album(albumImage: #imageLiteral(resourceName: "Mona Lisa - Leonardo da Vinci"), albumName: "Mona Lisa", artistName: "Leonardo da Vinci", year: 1503),
        Album(albumImage: #imageLiteral(resourceName: "No. 210:No. 211 - Mark Rothko"), albumName: "No. 210/211 Orange", artistName: "Mark Rothko", year: 1960),
        Album(albumImage: #imageLiteral(resourceName: "Blue Nude II - Henri Matisse"), albumName: "Blue Nude II", artistName: "Henri Matisse", year: 1952),
        Album(albumImage: #imageLiteral(resourceName: "Nighthawks - Edward Hopper"), albumName: "Nighthawks", artistName: "Edward Hopper", year: 1942),
        Album(albumImage: #imageLiteral(resourceName: "Number 1A - Jackson Pollock"), albumName: "Number 1A", artistName: "Jackson Pollock", year: 1948),
        Album(albumImage: #imageLiteral(resourceName: "Self-portrait Spring 1887 - Vincent Van Gogh"), albumName: "Self-Portrait", artistName: "Vincent Van Gogh", year: 1887),
    ]
    
    private let cellID = "cellID"
    private let cellSizeFactor: CGFloat = 0.8
    private lazy var cellSize: CGSize = {
        let w = self.view.frame.width
        return CGSize(width: w*self.cellSizeFactor, height: w)
    }()
    private lazy var cellSpacing: CGFloat = {
        return self.view.frame.width*((1-self.cellSizeFactor)/4)
    }()
    private lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        l.minimumInteritemSpacing = 0
        l.minimumLineSpacing = self.cellSpacing
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.isScrollEnabled = true
        c.isPagingEnabled = false
        c.showsHorizontalScrollIndicator = false
        c.showsVerticalScrollIndicator = false
        c.backgroundColor = .clear
        c.register(AlbumViewCell.self, forCellWithReuseIdentifier: self.cellID)
        c.dataSource = self
        c.delegate = self
        return c
    }()
    
    private let mainLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .left
        l.numberOfLines = 2
        l.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        return l
    }()
    
    private let secondaryLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .left
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        return l
    }()
    
    private let detailLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .left
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return l
    }()
    
    private var selectedIndex: IndexPath?
    private var timer: Timer?
    private let playButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysTemplate), for: .normal)
        b.tintColor = .white
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Add subviews
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.mainLabel)
        self.view.addSubview(self.secondaryLabel)
        self.view.addSubview(self.detailLabel)
        self.view.addSubview(self.playButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6),
            self.collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            self.mainLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: self.cellSizeFactor),
            self.mainLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.mainLabel.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor),
            
            self.secondaryLabel.widthAnchor.constraint(equalTo: self.mainLabel.widthAnchor),
            self.secondaryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.secondaryLabel.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            
            self.detailLabel.widthAnchor.constraint(equalTo: self.mainLabel.widthAnchor),
            self.detailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.detailLabel.topAnchor.constraint(equalTo: self.secondaryLabel.bottomAnchor),
            
            self.playButton.widthAnchor.constraint(equalToConstant: 24),
            self.playButton.heightAnchor.constraint(equalToConstant: 24),
            self.playButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            self.playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -12),
        ])
        
        // Set up play button
        self.playButton.addTarget(self, action: #selector(setupPlayTimer), for: .touchUpInside)
        
        // Update view
        self.selectedIndex = IndexPath(item: 0, section: 0)
        self.updateView(with: self.albums[0])
    }
    
    @objc func setupPlayTimer() {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(startPlaying), userInfo: nil, repeats: true)
            self.playButton.isHidden = true
        }
    }
    
    @objc func startPlaying() {
        if let index = self.selectedIndex {
            self.selectedIndex = IndexPath(item: (index.item+1)%self.albums.count, section: 0)
            self.goTo(indexPath: self.selectedIndex)
        }
    }
    
    func goTo(indexPath: IndexPath?) {
        if let index = indexPath {
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            self.updateView(with: self.albums[index.item])
        }
    }

    // Mark: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! AlbumViewCell
        cell.imageView.image = self.albums[indexPath.item].albumImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, self.cellSpacing*2, 0, self.cellSpacing*2)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let _ = self.timer {
            self.timer?.invalidate()
            self.timer = nil
             self.playButton.isHidden = false
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let rect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let mid = CGPoint(x: rect.midX, y: rect.midY)
        DispatchQueue.main.async {
            var smallestDiff = CGFloat.greatestFiniteMagnitude
            for index in self.collectionView.indexPathsForVisibleItems {
                if let cell = self.collectionView.cellForItem(at: index) {
                    let diff = abs((cell.frame.origin.x+(cell.frame.width/2))-mid.x)
                    if diff < smallestDiff {
                        smallestDiff = diff
                        self.selectedIndex = index
                    }
                }
            }
            
            self.goTo(indexPath: self.selectedIndex)
        }
    }
    
    private func updateView(with album: Album) {
        album.albumImage?.getColors(quality: .high) { colors in
            UIView.animate(withDuration: 0.15, animations: {
                self.view.backgroundColor = colors.background
                
                self.mainLabel.text = album.albumName
                self.mainLabel.textColor = colors.primary
                
                self.secondaryLabel.text = album.artistName
                self.secondaryLabel.textColor = colors.secondary
                
                self.detailLabel.text = "\(album.year)"
                self.detailLabel.textColor = colors.detail
                
                self.playButton.tintColor = colors.detail
            })
        }
    }
}

