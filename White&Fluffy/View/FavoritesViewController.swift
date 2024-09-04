//
//  FavoritesViewController.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import UIKit

class FavoritesViewController: UITableViewController {
    
    private var favoritePhotos: [UnsplashPhoto] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadFavorites()
    }
    
    private func loadFavorites() {

        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePhotos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        let photo = favoritePhotos[indexPath.row]
        cell.textLabel?.text = photo.user.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let photo = favoritePhotos[indexPath.row]
        let detailVC = PhotoDetailViewController(photo: photo)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
