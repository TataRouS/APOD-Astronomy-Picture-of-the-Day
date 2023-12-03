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
        
    //tabBar.tintColor = .red
        //tabBar.unselectedItemTintColor = .green
       // tabBar.barTintColor = .orange
        //UITabBar.appearance().barTintColor = .orange
    }
    
    //MARK: - Private functions

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: PictureOfDayBuilder.build(), title: "APOD", image: UIImage(systemName: "photo")),
            generateVC(viewController: DatePictureBuilder.build(), title: "DateAPOD", image: UIImage(systemName: "photo.on.rectangle")),
            generateVC(viewController: Favorite(), title: "Favorite", image: UIImage(systemName: "star.fill"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        //let item = UITabBarItem(title: title, image: image, tag: 0)
        let navController = UINavigationController(rootViewController: viewController)
        navController.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
