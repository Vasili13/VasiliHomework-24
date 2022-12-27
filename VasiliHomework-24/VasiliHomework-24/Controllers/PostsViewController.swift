//
//  PostsViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 27.12.22.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var postsTableView: UITableView!
    var user: User?
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.dataSource = self
        postsTableView.delegate = self
        fetchPosts()

    }
    
    func fetchPosts() {
        guard let userId = user?.id else { return }
        let pathUrl = "\(ApiConstants.postsPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data)
                print(self.posts)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
            }
        }
        task.resume()
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Posts", for: indexPath)
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Posts"
    }
}
