//
//  ViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 26.12.22.
//

import UIKit
import SnapKit

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case users = "Users"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MenuCVCell else { return UICollectionViewCell() }
        cell.userActionLabel.text = userActions[indexPath.row].rawValue
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        switch userAction {
        case .downloadImage:
            guard let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageVC") as? ImageViewController else { return }
            navigationController?.pushViewController(imageVC, animated: true)
        case .users:
            guard let userTVC = storyboard?.instantiateViewController(withIdentifier: "UsersViewController") as? UsersViewController else { return }
            navigationController?.pushViewController(userTVC, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (UIScreen.main.bounds.width - 20), height: 80)
    }
}
