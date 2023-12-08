//
//  PictureOfDayErrorView.swift
//  APOD
//
//  Created by Nata Kuznetsova on 30.11.2023.
//

import Foundation
import UIKit

protocol PictureOfDayErrorViewDelegate: AnyObject {
    func didTapRetryButton()
}

struct PictureOfDayErrorViewModel {
    let title: String
    let subtitle: String?
    let buttonTitle: String
}
    
class PictureOfDayErrorView: UIView {
    
    //MARK: - Properties

    var delegate: PictureOfDayErrorViewDelegate?
    
    //MARK: - Private properties

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.text = "Oшибка загрузки данных из сети"
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.text = "Oшибка загрузки данных из сети"
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        button.setTitle(" Попробовать снова ", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        button.layer.cornerRadius = 15
        return button
    }()
    
    // MARK: - Functions
    
    func setupData(_ model: PictureOfDayErrorViewModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        button.setTitle(model.buttonTitle, for: .normal)
    }
    
    @objc func didTapButton() {
        delegate?.didTapRetryButton()
    }
    
    // MARK: - 
    
    //MARK: - Private functions
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(button)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
