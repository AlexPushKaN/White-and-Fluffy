//
//  AppViewModel.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import Foundation
import Alamofire

protocol AppViewModelProtocol {
    
    var photos: [UnsplashPhoto] { get set }
    var filteredPhotos: [UnsplashPhoto] { get set }
    var favoritesPhotos: [UnsplashPhoto] { get }
    var onError: ((AFError) -> Void)? { get set }
    var onPhotosUpdated: (() -> Void)? { get set }
    func loadPhotos()
}

final class AppViewModel: AppViewModelProtocol {
    
    var photos: [UnsplashPhoto] = [] {
        didSet {
            filteredPhotos = photos
        }
    }
    var filteredPhotos: [UnsplashPhoto] = [] {
        didSet {
            onPhotosUpdated?()
        }
    }
    var favoritesPhotos: [UnsplashPhoto] {
        return photos.filter { $0.isFavorite }
    }
    
    private let networkingService: NetworkingProtocol
    
    var onError: ((AFError) -> Void)?
    var onPhotosUpdated: (() -> Void)?
    
    init(networkingService: NetworkingProtocol) {
        self.networkingService = networkingService
    }
    
    func loadPhotos() {
        networkingService.fetchRandomPhotos { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let photos):
                self.photos = photos
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
}
