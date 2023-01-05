//
//  PhotoFullSizeVC.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 4.01.23.
//

import UIKit
import SwiftyJSON

class PhotoFullSizeVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var photo: JSON?

    override func viewDidLoad() {
        super.viewDidLoad()
        getPhoto()
    }
    
    private func getPhoto() {
        guard let photo,
              let imageURL = photo["url"].string else { return }
        NetworkService.getPhoto(imageURL: imageURL) { [weak self]  image, error in
            self?.imageView.image = image
        }
    }
}
