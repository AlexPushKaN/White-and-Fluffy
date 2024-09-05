//
//  TabBarController.swift
//  White&Fluffy
//
//  Created by Александр Муклинов on 04.09.2024.
//

import UIKit

class TabBarController: UITabBarController {

    var appViewModel: AppViewModelProtocol!

    init(appViewModel: AppViewModelProtocol) {
        
        self.appViewModel = appViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        setupTabBarView()
    }

    private func setupTabBarView() {
        
        tabBar.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        tabBar.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.9956421256, green: 0.9758022428, blue: 0.9372857213, alpha: 1)
        tabBar.isTranslucent = false
        
        let photosVC = PhotosViewController(viewModel: appViewModel)
        photosVC.tabBarItem = UITabBarItem(title: "Коллекция", image: UIImage(systemName: "photo"), tag: 0)
        
        let favoritesVC = FavoritesViewController(viewModel: appViewModel)
        favoritesVC.tabBarItem = UITabBarItem(title: "Избранные", image: UIImage(systemName: "heart"), tag: 1)
        
        viewControllers = [
            UINavigationController(rootViewController: photosVC),
            UINavigationController(rootViewController: favoritesVC)
        ]
    }
}

//MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        (viewController as? UINavigationController)?.popViewController(animated: false)
    }
}
