//
//  MainTabBarController.swift
//  APOD
//
//  Created by Irina on 02.12.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    //MARK: - Private functions

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: PictureOfDayBuilder.build(), title: "APOD", image: UIImage(systemName: "photo")),
            generateVC(viewController: DatePictureBuilder.build(), title: "DateAPOD", image: UIImage(systemName: "photo.on.rectangle")),
            generateVC(viewController: FavoriteBuilder.build(), title: "Favorite", image: UIImage(systemName: "star.fill"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
