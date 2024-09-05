//
//  PhotoDetailViewController.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController {
    
    private var photo: UnsplashPhoto
    private let imageView = UIImageView()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    private let downloadsLabel = UILabel()
    private let favoriteButton = UIButton()

    var updatePhoto: ((UnsplashPhoto) -> Void)!
    
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
        
        setupSubviews()
        setupConstraints()
        configureData()
    }
    
    private func setupSubviews() {
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        authorLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dateLabel.font = .systemFont(ofSize: 14, weight: .light)
        locationLabel.font = .systemFont(ofSize: 14, weight: .light)
        downloadsLabel.font = .systemFont(ofSize: 14, weight: .light)
        
        updateFavoriteButton()
        favoriteButton.imageView?.contentMode = .scaleAspectFill
        favoriteButton.contentHorizontalAlignment = .fill
        favoriteButton.contentVerticalAlignment = .fill
        favoriteButton.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        [imageView,
         authorLabel,
         dateLabel,
         locationLabel,
         downloadsLabel,
         favoriteButton].forEach({ view.addSubview($0) })
    }
    
    private func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            downloadsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            downloadsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            downloadsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            favoriteButton.topAnchor.constraint(equalTo: downloadsLabel.bottomAnchor, constant: 40),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40.0),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40.0),
            favoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func configureData() {
        
        if let url = URL(string: photo.urls.regular) {
            imageView.kf.setImage(with: url)
        }
        authorLabel.text = "Автор: \(photo.user.name)"
        dateLabel.text = "Дата: \(photo.createdAt?.components(separatedBy: "T").first ?? "Нет даты")"
        locationLabel.text = "Локация: \(photo.location?.name ?? "Планета - Земля")"
        downloadsLabel.text = "Количество загрузок: \(photo.downloads ?? 0)"
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        
        let imageName = photo.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func favoriteButtonTapped() {
        
        photo.isFavorite.toggle()
        updatePhoto(photo)
        updateFavoriteButton()
    }
}
