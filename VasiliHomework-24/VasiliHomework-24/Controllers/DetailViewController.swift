//
//  DetailViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 27.12.22.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var user: User?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username:"
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone:"
        return label
    }()
    
    lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.text = "Website:"
        return label
    }()
    
    lazy var infoNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    lazy var infoUsernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    lazy var infoEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    lazy var infoPhoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    lazy var infoWebsiteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var adressInfo: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Adress", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(showMap), for: .touchUpInside)
        return btn
    }()
    
    lazy var postsBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        btn.setTitle("Posts", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(openPosts), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(websiteLabel)
        
        view.addSubview(infoNameLabel)
        view.addSubview(infoUsernameLabel)
        view.addSubview(infoEmailLabel)
        view.addSubview(infoPhoneLabel)
        view.addSubview(infoWebsiteLabel)
        
        view.addSubview(postsBtn)
        view.addSubview(adressInfo)
        updateViewConstraints()
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(120)
        }
        usernameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(nameLabel).offset(40)
        }
        emailLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(usernameLabel).offset(40)
        }
        phoneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(emailLabel).offset(40)
        }
        websiteLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(phoneLabel).offset(40)
        }
        
        infoNameLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(120)
        }
        infoUsernameLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(infoNameLabel).offset(40)
        }
        infoEmailLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(infoUsernameLabel).offset(40)
        }
        infoPhoneLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(infoEmailLabel).offset(40)
        }
        infoWebsiteLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(infoPhoneLabel).offset(40)
        }
        
        adressInfo.snp.makeConstraints { make in
            make.top.equalTo(infoWebsiteLabel).offset(40)
            make.centerX.equalToSuperview()
        }
        
        postsBtn.snp.makeConstraints { make in
            make.top.equalTo(adressInfo).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(100)
        }
    }
    
    @objc func openPosts() {
        guard let postsVC = UIStoryboard(name: "Posts", bundle: nil).instantiateViewController(withIdentifier: "PostsViewController") as? PostsViewController else { return }
        postsVC.user = user
        navigationController?.pushViewController(postsVC, animated: true)
    }
    
    @objc func showMap() {
        guard let mapVC = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        mapVC.user = user
        navigationController?.pushViewController(mapVC, animated: true)
    }
    private func setupUI() {
        infoNameLabel.text = user?.name
        infoUsernameLabel.text = user?.username
        infoEmailLabel.text = user?.email
        infoPhoneLabel.text = user?.phone
        infoWebsiteLabel.text = user?.website
    }
}
