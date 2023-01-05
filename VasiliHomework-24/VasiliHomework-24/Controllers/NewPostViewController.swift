//
//  NewPostViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 4.01.23.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class NewPostViewController: UIViewController {
    
    //MARK: - Variables
    var user: User?
    var posts: [Post] = []
    
    lazy var titleTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Title"
        field.borderStyle = .roundedRect
        return field
    }()
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.layer.shadowColor = UIColor.systemGray6.cgColor
        text.backgroundColor = .systemGray6
        return text
    }()
    
    lazy var postURLSessionBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .systemBlue
        btn.setTitle("Post With URLSession", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(postUrlSession), for: .touchUpInside)
        return btn
    }()
    
    lazy var postAlamofireBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .systemGray
        btn.setTitle("Post with Alamofire", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(postAlamofire), for: .touchUpInside)
        return btn
    }()

    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleTextField)
        view.addSubview(textView)
        view.addSubview(postURLSessionBtn)
        view.addSubview(postAlamofireBtn)
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        titleTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        textView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(300)
            make.top.equalTo(titleTextField.snp_bottomMargin).offset(16)
        }
        
        postURLSessionBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(textView.snp_bottomMargin).offset(40)
        }
        
        postAlamofireBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(postURLSessionBtn.snp_bottomMargin).offset(16)
        }
    }
    
    @objc func postAlamofire(){
        if let userID = user?.id,
           let title = titleTextField.text,
           let text = textView.text,
           let url = ApiConstants.postsPathURL
        {
            let parameters: Parameters = ["userId": userID,
                                          "title": title,
                                          "body": text]

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .response { response in
                    debugPrint(response)
                    debugPrint(response.result)

                    switch response.result {
                    case .success:
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
        
    }
    
    @objc func postUrlSession() {
        if let userID = user?.id,
           let title = titleTextField.text,
           let text = textView.text,
           let url = ApiConstants.postsPathURL
        {
            // SETUP request
            var request = URLRequest(url: url)

            // HEADER
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // BODY
            let postBodyJson: [String: Any] = ["userId": userID,
                                               "title": title,
                                               "body": text]

            let httpBody = try? JSONSerialization.data(withJSONObject: postBodyJson, options: [])
            request.httpBody = httpBody

            // Create dataTask and post new request

            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response ?? "")
                if let data {
                    print(data)
                    let json = JSON(data)
                    print(json)
                    let userID = json["userId"].int
                    let title = json["title"].string
                    let body = json["body"].string

                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                } else if let error {
                    print(error)
                }
            }.resume()
        }
    }
}
