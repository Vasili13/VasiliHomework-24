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
        title = "Posts"
        configurateNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    private func configurateNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .done, target: self, action: #selector(addNewPost))
    }
    
    @objc func addNewPost(){
        guard let newPostVC = storyboard?.instantiateViewController(withIdentifier: "NewPostViewController") as? NewPostViewController else { return }
        newPostVC.user = user
        navigationController?.pushViewController(newPostVC, animated: true)
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

//MARK: - Extension for tableView
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let commentVC = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController else { return }
//        navigationController?.pushViewController(commentVC, animated: true)
        performSegue(withIdentifier: "showComments", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CommentsViewController,
           let indexPath = sender as? IndexPath {
            let post = posts[indexPath.row]
            vc.postID = post.id
        } else if let vc = segue.destination as? NewPostViewController {
            vc.user = user
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let id = posts[indexPath.row].id {
            NetworkService.deletePost(postID: id) { [weak self] json, error in
                if json != nil {
                    self?.posts.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } else if let error = error {
                    print(error)
                }
            }
        }
    }
}
