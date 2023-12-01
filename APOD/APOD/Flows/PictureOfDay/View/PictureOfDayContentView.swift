//
//  PictureOfDayContentView.swift
//  APOD
//
//  Created by Nata Kuznetsova on 30.11.2023.
//

import Foundation
import UIKit

class PictureOfDayContentView: UIView {
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private var favorite: UIImageView = {
        let favorite = UIImageView(image: UIImage(systemName: "star"))
        return favorite
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var labelDescriptions: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentImage(apod: DataImage, data: Data){
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: data)
            self.labelTitle.text = apod.title
            self.labelDescriptions.text = apod.explanation
            
        }
    }
    
    private func setupViews() {
        addSubview(labelTitle)
        addSubview(favorite)
        //     favorite.addGestureRecognizer(gestureRecognizer)
        addSubview(imageView)
        addSubview(scrollView)
        scrollView.addSubview(labelDescriptions)
        setupConstraints()
    }
    
    private func setupConstraints() {
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        favorite.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        labelDescriptions.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            favorite.widthAnchor.constraint(equalToConstant: 30),
            favorite.heightAnchor.constraint(equalTo: favorite.widthAnchor),
            favorite.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favorite.leadingAnchor.constraint(equalTo: labelTitle.trailingAnchor, constant: 20),

            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: frame.size.width),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            labelDescriptions.topAnchor.constraint(equalTo: scrollView.topAnchor),
            labelDescriptions.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            labelDescriptions.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            labelDescriptions.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            labelDescriptions.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

