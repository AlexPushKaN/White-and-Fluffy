//
//  PhotoDetailViewController.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController {
    
    private let photo: UnsplashPhoto
    private let imageView = UIImageView()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    private let downloadsLabel = UILabel()
    private let favoriteButton = UIButton()

    init(photo: UnsplashPhoto) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configureData()
    }
    
    private func setupViews() {

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
    }
    
    private func configureData() {
        if let url = URL(string: photo.urls.regular) {
            imageView.kf.setImage(with: url)
        }
        authorLabel.text = "Author: \(photo.user.name)"
        dateLabel.text = "Date: \(photo.createdAt)"
        locationLabel.text = "Location: \(photo.location?.name ?? "Unknown")"
        downloadsLabel.text = "Downloads: \(photo.downloads)"
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {

    }
    
    @objc private func favoriteButtonTapped() {

    }
}
