//
//  ViewController.swift
//  APOD
//
//  Created by Nata Kuznetsova on 16.10.2023.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "APOD Title"
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "APODImage"))
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
        private var labelDescriptions: UILabel = {
            let label = UILabel()
            label.text = "APOD Discription"
            label.backgroundColor = .green
            label.textAlignment = .center
            return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        setupViews()
        
    func setupViews() {
            view.addSubview(labelTitle)
            view.addSubview(imageView)
            view.addSubview(labelDescriptions)
            setupConstraints()
        }
        
    
        
    }
        private func setupConstraints() {
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            labelDescriptions.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                labelTitle.widthAnchor.constraint(equalToConstant: 200),
                labelTitle.heightAnchor.constraint(equalToConstant: 200),
                
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: 200),
                imageView.heightAnchor.constraint(equalToConstant: 200),
                
                labelDescriptions.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                labelDescriptions.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                labelDescriptions.widthAnchor.constraint(equalToConstant: 200),
                labelDescriptions.heightAnchor.constraint(equalToConstant: 200),
                
            ])
        }
}



