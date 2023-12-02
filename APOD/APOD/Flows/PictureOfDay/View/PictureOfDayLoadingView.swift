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
    
    //MARK: - ????
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
