//
//  ViewController.swift
//  APOD
//
//  Created by Nata Kuznetsova on 16.10.2023.
//

import UIKit

protocol PictureOfDayProtocol {
    func viewDidLoad()
}

class PictureOfDayController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: PictureOfDayProtocol?
    
    //MARK: - Private properties
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    
    private var labelDescriptions: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    //MARK: - Construction
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has nit been implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        presenter?.viewDidLoad()
    }
    
    //MARK: - Functions
    
    //MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(labelTitle)
        view.addSubview(imageView)
        view.addSubview(labelDescriptions)
        setupConstraints()
    }
    
    private func setupConstraints() {
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelDescriptions.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            labelTitle.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            
            
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.size.width),
            //            imageView.widthAnchor.constraint(equalToConstant: 200),
            //            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            labelDescriptions.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelDescriptions.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            labelDescriptions.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelDescriptions.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension PictureOfDayController: PictureOfDayPresenterDelegate {
    func presentImage(apod: DataImage, data: Data){
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: data)
            self.labelTitle.text = apod.title
            self.labelDescriptions.text = apod.explanation
            
        }
    }
    
    func showAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Не удалось получить данные",
                                          message: "Данные актуальны",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
