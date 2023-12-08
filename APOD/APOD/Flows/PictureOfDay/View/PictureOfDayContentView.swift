//
//  PictureOfDayContentView.swift
//  APOD
//
//  Created by Nata Kuznetsova on 30.11.2023.
//

import Foundation
import UIKit

class PictureOfDayContentView: UIView {
    
    //MARK: - Properties
    
    var onTapPresenterController: ((Bool) -> Void)?
    
    //MARK: - Private properties
    
    private var starIsFilled: Bool = false
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.numberOfLines = 2
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
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
    
    //MARK: - Functions
    
    func setupViewWithModel(_ contentModel: PictureOfDayViewModel){
        let starImageName = contentModel.isFavorite ? "star.fill": "star"
        button.setImage(UIImage(systemName: starImageName), for: .normal)
        starIsFilled = contentModel.isFavorite
        imageView.image = contentModel.image
        labelTitle.text = contentModel.title
        labelDescriptions.text = contentModel.description
    }
    
    @objc func tap(){
        print("Power")
        if starIsFilled {
            button.setImage(UIImage(systemName: "star"), for: .normal)
            starIsFilled = false
        }else{
            button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starIsFilled = true
        }
        guard let onTapPresenterController = onTapPresenterController
        else {
            return
        }
        onTapPresenterController(starIsFilled)
    }
    
    
    
    //MARK: - Private functions
    
    
    private func setupViews() {
        addSubview(labelTitle)
        addSubview(button)
        print("setupViews")
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        button.addGestureRecognizer(gestureRecognizer)
        addSubview(imageView)
        addSubview(scrollView)
        scrollView.addSubview(labelDescriptions)
        setupConstraints()
    }
    
    private func setupConstraints() {
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        labelDescriptions.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            labelTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalTo: button.widthAnchor),
            button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            button.leadingAnchor.constraint(equalTo: labelTitle.trailingAnchor),
            
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
    
    private func toggleFavorite(starIsFilled: Bool){
        if starIsFilled {
            button.setImage(UIImage(systemName: "star"), for: .normal)
            self.starIsFilled = false
        }else{
            button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            self.starIsFilled = true
        }
    }
}
