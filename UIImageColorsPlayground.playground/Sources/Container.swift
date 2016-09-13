import UIKit

open class Album {
    open let albumFile: String
    open let albumName: String
    open let artistName: String
    open let year: Int
    
    public init(albumFile: String, albumName: String, artistName: String, year: Int) {
        self.albumFile = albumFile
        self.albumName = albumName
        self.artistName = artistName
        self.year = year
    }
}

open class Container: UIView {
    
    open var albumImageView: UIImageView!
    open var albumTitle:UILabel!
    open var artistTitle:UILabel!
    open var yearLabel:UILabel!
    
    public init(album: Album) {
        super.init(frame: CGRect(x: 0, y: 0, width: 444, height: 120))
        
        // Album artwork
        albumImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
        albumImageView.image = UIImage(named: album.albumFile)
        self.addSubview(albumImageView)
        
        // Text
        albumTitle = UILabel()
        albumTitle.font = UIFont(name: "Helvetica-Bold", size: 17)
        albumTitle.text = album.albumName
        albumTitle.sizeToFit()
        self.addSubview(albumTitle)
        
        artistTitle = UILabel()
        artistTitle.font = UIFont(name: "Helvetica-Bold", size: albumTitle.font.pointSize*0.75)
        artistTitle.text = album.artistName
        artistTitle.sizeToFit()
        self.addSubview(artistTitle)
        
        yearLabel = UILabel()
        yearLabel.font = artistTitle.font
        yearLabel.text = " · \(album.year)"
        yearLabel.sizeToFit()
        self.addSubview(yearLabel)
        
        // Set frames
        let labelHeight = artistTitle.frame.height
        albumTitle.frame.size.width = self.frame.width - albumImageView.frame.width - (labelHeight * 2)
        albumTitle.frame.origin = CGPoint(x: floor(albumImageView.frame.width + labelHeight), y: floor(self.frame.height/2 - labelHeight))
        artistTitle.frame.origin = CGPoint(x: albumTitle.frame.origin.x, y: floor(albumTitle.frame.origin.y + labelHeight*1.5))
        yearLabel.frame.origin = CGPoint(x: artistTitle.frame.origin.x + artistTitle.frame.width, y: artistTitle.frame.origin.y)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
