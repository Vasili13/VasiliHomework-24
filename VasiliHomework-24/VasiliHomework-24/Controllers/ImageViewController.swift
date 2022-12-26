//
//  ImageViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 27.12.22.
//

import UIKit
import SnapKit

class ImageViewController: UIViewController {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var folderImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let imageURL = "https://wallpapershome.ru/images/pages/pic_h/3950.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        view.addSubview(folderImage)
        view.addSubview(activityIndicator)
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        activityIndicator.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        folderImage.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    private func fetchImage() {
        guard let url = URL(string: imageURL) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            DispatchQueue.main.async {
                
                self.activityIndicator.stopAnimating()
                
                if let error = error {
                    print(error.localizedDescription)
                    // добавить дефолтную картинку и отобразить ошибку
                    return
                }
                
                if let response {
                    print(response)
                }
                
                print("\n", data ?? "", "\n")
                
                if let data,
                   let image = UIImage(data: data)
                {
                    self.folderImage.image = image
                } else {
                    // добавить дефолтную картинку
                }
                
            }
        }//.resume()
        task.resume()
    }
}
