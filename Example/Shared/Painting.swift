//
//  Painting.swift
//  Example
//
//  Created by Felix Herrmann on 13.10.21.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@objc
@objcMembers
public final class Painting: NSObject {
    public let name: String
    #if canImport(UIKit)
    public let image: UIImage
    #elseif canImport(AppKit)
    public let image: NSImage
    #endif
    public let artist: String
    public let year: Int
    
    #if canImport(UIKit)
    init(name: String, image: UIImage, artist: String, year: Int) {
        self.name = name
        self.image = image
        self.artist = artist
        self.year = year
    }
    #elseif canImport(AppKit)
    init(name: String, image: NSImage, artist: String, year: Int) {
        self.name = name
        self.image = image
        self.artist = artist
        self.year = year
    }
    #endif
}

extension Painting {
    
    @objc public static let examples = [
        Painting(name: "Calvin Klein", image: #imageLiteral(resourceName: "Calvin Klein - Kaws"), artist: "Kaws", year: 1999),
        Painting(name: "Cafe Terrace at Night", image: #imageLiteral(resourceName: "Cafe Terrace at Night - Vincent Van Gogh"), artist: "Vincent Van Gogh", year: 1888),
        Painting(name: "Woman I", image: #imageLiteral(resourceName: "Woman I - Willem de Kooning"), artist: "Willem de Kooning", year: 1952),
        Painting(name: "Skull", image: #imageLiteral(resourceName: "Skull - Jean-Michel Basquiat"), artist: "Jean-Michel Basquiat", year: 1981),
        Painting(name: "Les Demoiselles d'Avignon", image: #imageLiteral(resourceName: "Les Demoiselles d'Avignon - Picasso"), artist: "Pablo Picasso", year: 1907),
        Painting(name: "Le Rêve", image: #imageLiteral(resourceName: "Le Reve - Pablo Picasso"), artist: "Pablo Picasso", year: 1932),
        Painting(name: "Mona Lisa", image: #imageLiteral(resourceName: "Mona Lisa - Leonardo da Vinci"), artist: "Leonardo da Vinci", year: 1503),
        Painting(name: "No. 210/211 Orange", image: #imageLiteral(resourceName: "No. 210:No. 211 - Mark Rothko"), artist: "Mark Rothko", year: 1960),
        Painting(name: "Blue Nude II", image: #imageLiteral(resourceName: "Blue Nude II - Henri Matisse"), artist: "Henri Matisse", year: 1952),
        Painting(name: "Nighthawks", image: #imageLiteral(resourceName: "Nighthawks - Edward Hopper"), artist: "Edward Hopper", year: 1942),
        Painting(name: "Number 1A", image: #imageLiteral(resourceName: "Number 1A - Jackson Pollock"), artist: "Jackson Pollock", year: 1948),
        Painting(name: "Self-Portrait", image: #imageLiteral(resourceName: "Self-portrait Spring 1887 - Vincent Van Gogh"), artist: "Vincent Van Gogh", year: 1887)
    ]
}
