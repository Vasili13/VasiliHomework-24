//
//  PhotoVC.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 4.01.23.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import SnapKit

class PhotoVC: UIViewController {
    
    var user: User?
    var album: JSON?
    var photos: [JSON] = []
    
    lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "PhotoCVCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCVCell")
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        view.addSubview(photoCollectionView)
        updateViewConstraints()
        getData()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        photoCollectionView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
    
    func getData() {
        if let album,
           let albumID = album["id"].int {
            
            NetworkService.getPhotos(albomID: albumID) { [weak self] response, error in
                guard let photos = response else { return }
                self?.photos = photos
                self?.photoCollectionView.reloadData()
            }
        }
    }
}

extension PhotoVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVCell", for: indexPath) as? PhotoCVCell {
            cell.thumbnailUrl = photos[indexPath.row]["thumbnailUrl"].string
            return cell
        }
        collectionView.reloadData()
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let photoFullSizeVC = UIStoryboard(name: "AlbumsAndPhotos", bundle: nil).instantiateViewController(withIdentifier: "PhotoFullSizeVC") as? PhotoFullSizeVC else { return }
//        photoFullSizeVC.photo = photo
//        present(photoFullSizeVC, animated: true)
        performSegue(withIdentifier: "showPhoto", sender: photos[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoVC = segue.destination as? PhotoFullSizeVC,
           let photo = sender as? JSON {
            photoVC.photo = photo
        }
    }
}

extension PhotoVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        return CGSize(width: sizeWH, height: sizeWH)
    }
}
