//
//  UnsplashPhoto.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import Foundation

struct UnsplashPhoto: Decodable {
    
    let id: String
    let createdAt: String?
    let width: Int
    let height: Int
    let color: String?
    let likes: Int
    let downloads: Int?
    let description: String?
    let urls: URLS
    let user: User
    let location: Location?

    struct URLS: Decodable {
        
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
    }
    
    struct User: Decodable {
        
        let id: String
        let username: String
        let name: String
        let profileImage: ProfileImage?

        struct ProfileImage: Decodable {
            let small: String
            let medium: String
            let large: String
        }
    }
    
    struct Location: Decodable {
        
        let name: String?
    }
}
