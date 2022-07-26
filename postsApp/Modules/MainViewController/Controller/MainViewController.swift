//
//  MainViewController.swift
//  postsApp
//
//  Created by Abai Kush on 23/7/22.
//

import UIKit

class MainViewController: UIViewController{
    
    @IBOutlet weak var mainTableView: UITableView!
    
    let networkManager = NetworkManager.shared
    
    var users: [UserModel] = []
    var posts: [PostModel] = []
    var isUsers: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.separatorStyle = .none
        
        networkManager.usersDelegate = self
        networkManager.postsDelegate = self
    }
    
    @IBAction func usersButtonTapped(_ sender: UIButton) {
        let url = "https://jsonplaceholder.typicode.com/users"
        networkManager.getUsers(urlString: url)
    }
    
    @IBAction func postsButtonTapped(_ sender: UIButton) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        networkManager.getPosts(urlString: url)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isUsers{
            return users.count
        }else{
            return posts.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        
        if self.isUsers{
            let user = users[indexPath.row]
            
            cell.nameLabel.text = user.name
            cell.emailLabel.text = user.email
            cell.phoneLabel.text = user.phone
        }else{
            let post = posts[indexPath.row]
            
            cell.nameLabel.text = String(post.id)
            cell.emailLabel.text = post.title
            cell.phoneLabel.text = post.body
        }
        return cell
    }
}

extension MainViewController: GetUsersProtocol{
    
    func getUsers(users: [UserModel]) {
        self.isUsers = true
        self.users.removeAll()
        self.users = users
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
        
    }
    
    func errorGettingUsers(error: String) {
        print("Error \(error)")
    }
}

extension MainViewController: GetPostsProtocol{
    
    func getPosts(posts: [PostModel]) {
        print("Posts: \(posts)")
        
        self.isUsers = false
        self.posts.removeAll()
        self.posts = posts
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    func errorGettingPosts(error: String) {
        print("Error \(error)")
    }
}
