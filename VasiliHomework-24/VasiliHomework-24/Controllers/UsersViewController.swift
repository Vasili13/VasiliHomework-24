//
//  UsersViewController.swift
//  VasiliHomework-24
//
//  Created by Василий Вырвич on 27.12.22.
//

import UIKit

class UsersViewController: UIViewController {
    var users: [User] = []
    @IBOutlet var usersTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        fetchUsers()
        title = "Users"
        // Do any additional setup after loading the view.
    }

    private func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

            if let error = error {
                print(error)
            }

            guard let data = data else { return }

            do {
                self?.users = try JSONDecoder().decode([User].self, from: data)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self?.usersTableView.reloadData()
            }
        }
        task.resume()
    }
}

// MARK: - Extension for tableView

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTVCell", for: indexPath)

        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.username

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.user = user
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
