//
//  AlbumsViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 4.01.23.
//

import UIKit
import SwiftyJSON
import Alamofire
import SnapKit

class AlbumsViewController: UIViewController {
    
    var user: User?
    var albums: [JSON] = []
    
    lazy var albumTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(albumTableView)
        
        title = "Albums"
        updateViewConstraints()
        getData()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        albumTableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
    
    private func getData() {
        guard let userID = user?.id,
              let url = URL(string: "\(ApiConstants.albumsPath)?userId=\(userID)") else { return }
        
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                self.albums = JSON(data).arrayValue
                self.albumTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = albums[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let photoVC = UIStoryboard(name: "AlbumsAndPhotos", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as? PhotoVC else { return }
//        photoVC.user = user
//        photoVC.album = albums
//        navigationController?.pushViewController(photoVC, animated: true)
        let album = albums[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: album)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
            let photosCollectionVC = segue.destination as? PhotoVC,
            let album = sender as? JSON {
            photosCollectionVC.user = user
            photosCollectionVC.album = album
        }
    }
}
