//
//  NewPostViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 4.01.23.
//

import UIKit
import SnapKit

class NewPostViewController: UIViewController {
    
    //MARK: - Variables
    var user: User?
    var posts: [Post] = []
    
    lazy var titleTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Title"
        field.borderStyle = .line
        return field
    }()
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.layer.shadowColor = UIColor.gray.cgColor
        text.backgroundColor = .gray
        return text
    }()
    
    lazy var postURLSessionBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .systemBlue
        btn.setTitle("Post With URLSession", for: .normal)
        btn.addTarget(self, action: #selector(postUrlSession), for: .touchUpInside)
        return btn
    }()
    
    lazy var postAlamofireBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .systemGray
        btn.setTitle("Post with Alamofire", for: .normal)
        btn.addTarget(self, action: #selector(postAlamofire), for: .touchUpInside)
        return btn
    }()

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
        
        postURLSessionBtn.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        textView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalTo(140)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.width.equalTo(100)
        }
        
        postAlamofireBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerX.centerY.equalToSuperview().offset(40)
            make.width.equalTo(100)
        }
    }
    
    @objc func postAlamofire(){
        print("alamofire")
    }
    
    @objc func postUrlSession() {
        print("url")
    }
}
