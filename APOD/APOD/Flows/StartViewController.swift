//
//  StartViewController.swift
//  APOD
//
//  Created by Irina on 29.11.2023.
//
//
//import UIKit
//
//class StartViewController: UIViewController {
//    
//    //MARK: - Private properties
//
//    private let backgroundImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "startImage"))
//        return imageView
//    }()
//    
//    private let button: UIButton = {
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
//        button.setTitle("N A S A", for: .normal)
//        //button.backgroundColor = .white
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 37)
//        button.addTarget(self,
//                         action: #selector(didTapButton),
//                         for: .touchUpInside)
//        return button
//    }()
//    
//    @objc func didTapButton() {
//        
//        let tabBarVC = UITabBarController()
//        
//        let vc1 = UINavigationController(rootViewController: PictureOfDayBuilder.build())
//        let vc2 = UINavigationController(rootViewController: DatePictureBuilder.build())
//        let vc3 = FavoriteScreenViewController()
//    
//        vc1.tabBarItem.title = "APOD"
//        vc1.tabBarItem.image = UIImage(systemName: "photo")
//        
//        vc2.tabBarItem.title = "DateAPOD"
//        vc2.tabBarItem.image = UIImage(systemName: "photo.on.rectangle")
//        
//        vc3.tabBarItem.title = "Favorite"
//        vc3.tabBarItem.image = UIImage(systemName: "star.fill")
//        
//        tabBarVC.setViewControllers([vc1, vc2, vc3], animated: false)
//        
//        tabBarVC.modalPresentationStyle = .fullScreen
//        present(tabBarVC, animated: true)
//    }
//    
//    //MARK: - Life cycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//    }
//    
//    //MARK: - Functions
//    
//    //MARK: - Private functions
//    
//    private func setupViews() {
//        view.addSubview(backgroundImageView)
//        view.addSubview(button)
//        setupConstraints()
//    }
//        
//    private func setupConstraints() {
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//        button.translatesAutoresizingMaskIntoConstraints = false
//            
//        NSLayoutConstraint.activate([
//            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                
//            button.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor)
//        ])
//    }
//}
