//
//  NetworkingService.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import Foundation
import Alamofire

protocol NetworkingProtocol {
    func fetchRandomPhotos(completion: @escaping (Result<[UnsplashPhoto], AFError>) -> Void)
}

final class NetworkingService: NetworkingProtocol {
    
    private let accessKey = "WE6Ns7ElAQz1VxJEDd0l1o4Wq7tIsSfl-wEwWQt5yRs"
    private lazy var baseURL = "https://api.unsplash.com/photos/random?client_id=\(accessKey)&count=30"
    
    func fetchRandomPhotos(completion: @escaping (Result<[UnsplashPhoto], AFError>) -> Void) {
        AF.request(baseURL).responseDecodable(of: [UnsplashPhoto].self) { response in
            completion(response.result)
        }
    }
}
