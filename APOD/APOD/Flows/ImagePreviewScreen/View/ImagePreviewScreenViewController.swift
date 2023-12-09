//
//  ImagePreviewScreenViewController.swift
//  APOD
//
//  Created by Alexander Rubtsov on 09.12.2023.
//

import Foundation
import UIKit
import DGZoomableImageView

protocol ImagePreviewScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class ImagePreviewScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: ImagePreviewScreenPresenterProtocol?
    
    // MARK: - Private properties
    
    private var imageView: DGZoomableImageView = {
        let imageView = DGZoomableImageView()
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
}

extension ImagePreviewScreenViewController: ImagePreviewScreenPresenterDelegate {
    func presentImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func dismissScreen() {
        dismiss(animated: true)
    }
}
