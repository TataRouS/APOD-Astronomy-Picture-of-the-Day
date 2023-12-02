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
    
class PictureOfDayErrorView: UIView {
    
    //MARK: - Properties

    var delegate: PictureOfDayErrorViewDelegate?
    
    //MARK: - Private properties

    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        //label.backgroundColor = .white
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
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Functions
    
    @objc func didTapButton() {
        delegate?.didTapRetryButton()
    }
    
    //MARK: - Private functions
    
    private func setupViews() {
        addSubview(label)
        addSubview(button)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// label  ошибка загрузки данных из сети
//кнопка попробовать снова
//(через делегат просим презентер заного загрузить)
//протокол подключаю
//target: delegat:didTapRetryButton()



    

