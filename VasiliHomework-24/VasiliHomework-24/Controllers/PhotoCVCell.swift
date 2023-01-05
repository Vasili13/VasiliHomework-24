//
//  PhotoCVCell.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 5.01.23.
//

import UIKit

class PhotoCVCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var thumbnailUrl: String? {
        didSet {
            getThumbnail()
        }
    }
    
    private func getThumbnail() {
        guard let thumbnailUrl = thumbnailUrl else { return }
        NetworkService.getPhoto(imageURL: thumbnailUrl) { [weak self]  image, error in
            self?.indicator.stopAnimating()
            self?.imageView.image = image
        }
    }
}
