//
//  FavoriteCell.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 05.09.2024.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseIdentifier = "FavoriteCell"
    
    private let photoImageView = UIImageView()
    private let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 5.0
        nameLabel.font = .systemFont(ofSize: 16.0, weight: .medium)
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 40.0),
            photoImageView.heightAnchor.constraint(equalToConstant: 40.0),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
        ])
    }
    
    func configure(with photo: UnsplashPhoto) {
        
        nameLabel.text = photo.user.name

        if let url = URL(string: photo.urls.small) {
            photoImageView.kf.setImage(with: url)
        }
    }
}
