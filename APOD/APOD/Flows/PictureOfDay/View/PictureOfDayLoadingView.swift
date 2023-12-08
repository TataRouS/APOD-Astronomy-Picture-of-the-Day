//
//  PictureOfDayLoadingView.swift
//  APOD
//
//  Created by Nata Kuznetsova on 30.11.2023.
//

import Foundation
import UIKit

class PictureOfDayLoadingView: UIView {
    
    //MARK: - Private properties
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.startAnimating()
        return loader
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 22)
        label.numberOfLines = 2
        label.text = "Astronomy Picture of the Day"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Construction
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func setActivityIndicatorAnimating(isAnimating: Bool) {
        if isAnimating {
            loader.startAnimating()
        } else {
            loader.stopAnimating()
        }
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(loader)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.bottomAnchor.constraint(equalTo: loader.topAnchor, constant: -80),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
