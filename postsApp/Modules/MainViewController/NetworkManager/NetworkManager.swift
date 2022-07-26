//
//  NetworkManager.swift
//  postsApp
//
//  Created by Abai Kush on 23/7/22.
//

import UIKit

protocol GetUsersProtocol{
    func getUsers(users: [UserModel])
    func errorGettingUsers(error: String)
}
protocol GetPostsProtocol{
    func getPosts(posts: [PostModel])
    func errorGettingPosts(error: String)
    
}
class NetworkManager{
    static let shared = NetworkManager()
    
    var usersDelegate: GetUsersProtocol?
    var postsDelegate: GetPostsProtocol?
    
    func getUsers(urlString: String){
        let url = URL(string: urlString)
        
        let session = URLSession(configuration: .default)
        
        if let url = url {
            let task = session.dataTask(with: url) {
                data, response, error in
                
                if let data = data {
                    if let users =
                        self.parseUsersJSON (usersData: data){
                        self.usersDelegate?.getUsers (users: users)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseUsersJSON(usersData: Data) -> [UserModel]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try
            decoder.decode([UserModel].self, from: usersData)
            
            let users: [UserModel] = decodedData
            
            return users
            
        } catch{
            usersDelegate?.errorGettingUsers(error: "Error found!")
            return nil
        }
    }
    func getPosts(urlString: String){
        let url = URL(string: urlString)
        
        let session = URLSession(configuration: .default)
        
        if let url = url {
            let task = session.dataTask(with: url) {
                data, response, error in
                
                if let data = data {
                    if let posts =
                        self.parsePostsJSON (postsData: data){
                        self.postsDelegate?.getPosts(posts: posts)
                    }
                }
            }
            task.resume()
        }
    }
    func parsePostsJSON(postsData: Data) -> [PostModel]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try
            decoder.decode([PostModel].self, from: postsData)
            
            let posts: [PostModel] = decodedData
            
            return posts
            
        } catch{
            self.postsDelegate?.errorGettingPosts(error: "Error Found!")
            return nil
        }
    }
}

