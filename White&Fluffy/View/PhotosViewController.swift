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
        
        title = "Photos"
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        setupCollectionView()
        setupSearchBar()
        binding()
        
        viewModel.loadPhotos()
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    private func setupSearchBar() {
        
        searchBar.delegate = self
        searchBar.placeholder = "Search Photos"
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
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int { viewModel.photos.count }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = viewModel.photos[indexPath.item]
        cell.configure(with: photo)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let photo = viewModel.photos[indexPath.item]
        let detailVC = PhotoDetailViewController(photo: photo)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension PhotosViewController: UISearchBarDelegate {
    
    
}
