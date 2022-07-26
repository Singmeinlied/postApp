//
//  UserModel.swift
//  postsApp
//
//  Created by Abai Kush on 23/7/22.
//

import Foundation

struct UserModel: Decodable{
    let id: Int
    let name: String
    let email: String
    let phone: String
}
