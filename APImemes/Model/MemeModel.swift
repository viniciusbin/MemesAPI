//
//  MemeModel.swift
//  APImemes
//
//  Created by Vinicius on 15/09/22.
//

import Foundation

struct Meme: Codable {
    
    let success: Bool
    let data: Data
}

struct Data: Codable {
    let memes: [MemeObj]
    
}

struct MemeObj: Codable {
    let id: String
    let name: String
    let url: String
    let width: Int
    let height: Int
    let box_count: Int
    
    
    
}
//enum CodingKeys: String, CodingKey {
//    case sucess, id, name, url, widht, height
//    case boxCount = "box_count"
//}
