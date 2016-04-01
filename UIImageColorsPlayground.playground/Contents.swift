//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let Albums: [Album] = [
    Album(albumFile: "OK Computer.png", albumName: "OK Computer", artistName: "Radiohead", year: 1997),
    Album(albumFile: "Nothing Was the Same.png", albumName: "Nothing Was the Same", artistName: "Drake", year: 2013),
    Album(albumFile: "My Beautiful Dark Twisted Fantasy.png", albumName: "My Beautiful Dark Twisted Fantasy", artistName: "Kanye West", year: 2010),
    Album(albumFile: "Kind of Blue.png", albumName: "Kind of Blue", artistName: "Miles Davis", year: 1959),
    Album(albumFile: "If You're Reading This It's Too Late.png", albumName: "If You're Reading This It's Too Late", artistName: "Drake", year: 2015),
    Album(albumFile: "New Morning.png", albumName: "New Morning", artistName: "Bob Dylan", year: 1970),
    Album(albumFile: "Since I Left You.png", albumName: "Since I Left You", artistName: "The Avalanches", year: 2000),
    Album(albumFile: "Random Access Memories.png", albumName: "Random Access Memories", artistName: "Daft Punk", year: 2013),
    Album(albumFile: "The Eraser.png", albumName: "The Eraser", artistName: "Thome Yorke", year: 2006),
    Album(albumFile: "Operation Doomsday.png", albumName: "Operation Doomsday", artistName: "MF Doom", year: 1999),
    Album(albumFile: "Cupid Deluxe.png", albumName: "Cupid Deluxe", artistName: "Blood Orange", year: 2013),
    Album(albumFile: "Black on Both Sides.png", albumName: "Black on Both Sides", artistName: "Mos Def", year: 1999)
]

let sample = Container(album: Albums[0])
let box = UIView(frame: CGRectMake(0, 0, sample.frame.width * 2, ceil(CGFloat(Albums.count)/2) * sample.frame.height))

for (i, album) in Albums.enumerate() {
    let c = Container(album: Albums[i])
    
    c.albumImageView.image!.getColors({ (colors) in
        c.backgroundColor = colors.backgroundColor
        c.albumTitle.textColor = colors.primaryColor
        c.artistTitle.textColor = colors.secondaryColor
        c.yearLabel.textColor = colors.detailColor
        
        if i == Albums.count-1 {
            box.alpha = 1; // Just a random call to be able to see the box
            XCPlaygroundPage.currentPage.finishExecution()
        }
    })
    
    c.frame.origin = CGPointMake((i%2 == 0) ? 0:sample.frame.width, sample.frame.height * floor(CGFloat(i)/2))
    
    box.addSubview(c)
}
