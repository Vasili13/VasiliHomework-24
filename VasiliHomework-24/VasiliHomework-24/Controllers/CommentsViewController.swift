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
        fetchComments()
    }
    
    func fetchComments() {
        guard let postID else {
            return
        }
        let pathURL = "\(ApiConstants.commentsPath)?postId=\(postID)"
        guard let url = URL(string: pathURL) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else {
                return
            }
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: data)
                print(self.comments)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.commentsTableView.reloadData()
            }
        }
        task.resume()
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
