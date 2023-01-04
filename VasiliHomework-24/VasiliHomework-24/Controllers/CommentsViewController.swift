//
//  CommentsViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 4.01.23.
//

import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    var postID: Int?
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comments"
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
    }

}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = comment.name
        cell.detailTextLabel?.text = comment.body
        return cell
    }
    
    
}
