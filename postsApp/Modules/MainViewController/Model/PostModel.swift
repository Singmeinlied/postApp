//
//  PostModel.swift
//  postsApp
//
//  Created by Abai Kush on 23/7/22.
//

import Foundation

struct PostModel: Decodable{
    let id: Int
    let title: String
    let body: String
}
