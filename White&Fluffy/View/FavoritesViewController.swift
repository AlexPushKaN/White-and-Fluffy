//
//  FavoritesViewController.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import UIKit

class FavoritesViewController: UITableViewController {
    
    private var viewModel: AppViewModelProtocol!
    
    init(viewModel: AppViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Избранные"
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: #colorLiteral(red: 0.8085320592, green: 0.02181939222, blue: 0.3326718211, alpha: 1),
            .font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favoritesPhotos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as! FavoriteCell
        cell.configure(with: viewModel.favoritesPhotos[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let photo = viewModel.favoritesPhotos[indexPath.row]
        let detailVC = PhotoDetailViewController(photo: photo)
        
        detailVC.updatePhoto = { [unowned self] favoritesPhoto in
            
            if let index = viewModel.photos.firstIndex(where: { $0.id == favoritesPhoto.id }) {
                viewModel.photos[index].isFavorite = favoritesPhoto.isFavorite
            }
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
