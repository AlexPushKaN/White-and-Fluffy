//
//  PhotosViewController.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import UIKit
import Alamofire

final class PhotosViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let searchBar = UISearchBar()
    
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
        
        title = "Коллекция"
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        setupCollectionView()
        setupSearchBar()
        binding()
        
        viewModel.loadPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupSearchBar() {
        
        searchBar.delegate = self
        searchBar.placeholder = "Поиск"
        searchBar.showsCancelButton = true
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitleColor(#colorLiteral(red: 0.8078431487,
                                                     green: 0.02745098062,
                                                     blue: 0.3333333433,
                                                     alpha: 1), 
                                       for: .normal)
            cancelButton.setTitle("Отмена", for: .normal)
        }
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.9956421256, green: 0.9758022428, blue: 0.9372857213, alpha: 1)
        searchBar.searchTextField.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        searchBar.searchTextField.layer.borderWidth = 2.0
        searchBar.searchTextField.layer.cornerRadius = 10.0
        navigationItem.titleView = searchBar
    }
    
    private func showErrorAlert(with errorMessage: AFError) {

        let alert = UIAlertController(title: "Ups!",
                                      message: errorMessage.errorDescription?.components(separatedBy: ":").last,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    //MARK: - Binding
    private func binding() {
        
        viewModel.onError = { [unowned self] error in
            showErrorAlert(with: error)
        }
        
        viewModel.onPhotosUpdated = { [unowned self] in
            collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin = 10.0
        let width = (view.frame.width - margin * 3) / 2
        return CGSize(width: width, height: width)
    }
}

//MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filteredPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = viewModel.filteredPhotos[indexPath.item]
        cell.configure(with: photo)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photo = viewModel.filteredPhotos[indexPath.item]
        let detailVC = PhotoDetailViewController(photo: photo)
        detailVC.updatePhoto = { [unowned self] favoritesPhoto in
            if let index = viewModel.photos.firstIndex(where: { $0.id == favoritesPhoto.id }) {
                viewModel.photos[index].isFavorite = favoritesPhoto.isFavorite
            }
        }

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension PhotosViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty { 
            viewModel.filteredPhotos = viewModel.photos
        } else {
            viewModel.filteredPhotos = viewModel.photos.filter { photo in
                guard let description = photo.description else { return false }
                return description.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filteredPhotos = viewModel.photos
    }
}
