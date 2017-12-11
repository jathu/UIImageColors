//
//  Album.swift
//  UIImageColorsExample
//
//  Created by Jathu Satkunarajah on 2017-11-30 - Toronto
//  Copyright © 2017 Jathu Satkunarajah. All rights reserved.
//

import UIKit

struct Album {
    let albumImage: UIImage?
    let albumName: String
    let artistName: String
    let year: Int
    
    public init(albumImage: UIImage?, albumName: String, artistName: String, year: Int) {
        self.albumImage = albumImage
        self.albumName = albumName
        self.artistName = artistName
        self.year = year
    }
}
