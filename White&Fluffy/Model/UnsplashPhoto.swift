//
//  UnsplashPhoto.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import Foundation

struct UnsplashPhoto: Decodable {
    
    var isFavorite: Bool = false
    
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

    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        color = try container.decodeIfPresent(String.self, forKey: .color)
        likes = try container.decode(Int.self, forKey: .likes)
        downloads = try container.decodeIfPresent(Int.self, forKey: .downloads)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        urls = try container.decode(URLS.self, forKey: .urls)
        user = try container.decode(User.self, forKey: .user)
        location = try container.decodeIfPresent(Location.self, forKey: .location)
    }

    private enum CodingKeys: String, CodingKey {
        
        case id
        case createdAt = "created_at"
        case width
        case height
        case color
        case likes
        case downloads
        case description
        case urls
        case user
        case location
    }
}
