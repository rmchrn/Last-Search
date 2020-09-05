//
//  AlbumTableViewCell.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var albumName: UILabel!
    
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    @IBOutlet weak var artistTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateData(withAlbum album: Album) {
        self.albumName.text = album.name
        self.artistName.text = album.artist
        let image = album.image.first { (image) -> Bool in
            image.size == .medium
        }
        if let imageURLString = image?.text {
            let url = URL(string: imageURLString)
            self.albumImage.setRemoteImage(url: url)
        } else {
            self.albumImage.image = nil
        }
    }
    
    func updateData(withAlbum artist: Artist) {
        self.artistName.text = artist.name
        self.albumName.isHidden = true
        self.albumTitleLabel.isHidden = true
        let image = artist.image.first { (image) -> Bool in
            image.size == .medium
        }
        if let imageURLString = image?.text {
            let url = URL(string: imageURLString)
            self.albumImage.setRemoteImage(url: url)
        } else {
            self.albumImage.image = nil
        }
    }
    
    func updateData(withAlbum album: Track) {
        self.albumName.text = album.name
        self.artistName.text = album.artist
        let image = album.image.first { (image) -> Bool in
            image.size == .medium
        }
        if let imageURLString = image?.text {
            let url = URL(string: imageURLString)
            self.albumImage.setRemoteImage(url: url)
        } else {
            self.albumImage.image = nil
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
