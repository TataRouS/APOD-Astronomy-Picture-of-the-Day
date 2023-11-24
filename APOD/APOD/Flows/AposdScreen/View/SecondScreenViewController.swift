//
//  SecondScreenViewController.swift
//  APOD
//
//  Created by Irina on 04.11.2023.
//

import UIKit

class SecondScreenViewController: UIViewController {

    private var labelTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var dateLabel: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerAction(sender:)), for: .valueChanged)
        return datePicker
    }()
    
    @objc func datePickerAction(sender: UIDatePicker) {
        let selectedDate = dateFormatter.string(from: sender.date)
        
//        networkController.fetchPhotoInfo(date: selectedDate) { [weak self] photoInfo in
//            if let photoInfo = photoInfo {
//                self?.updateUI(with: photoInfo)
//            }
//        }
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has nit been implemented")
    }
    
    private var aposdPresenter = AposdPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setInitView()
        
        aposdPresenter.setViewDelegate(delegate: self)
        aposdPresenter.updateUI()
    }
    
        
    func setupViews() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
        view.addSubview(labelTitle)
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        view.addSubview(dateLabel)
        setupConstraints()
    }
        
        private func setupConstraints() {
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                labelTitle.widthAnchor.constraint(equalToConstant: view.frame.size.width),
                
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
                imageView.heightAnchor.constraint(equalToConstant: view.frame.size.width),
                
                dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
    
    let networkController = NetworkController()
    let dateFormatter = DateFormatter()
    
    private func setInitView() {
        descriptionLabel.text = ""

        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateLabel.maximumDate = .now
    }
    
    func updateUI(with photoInfo: DataImage) {
        networkController.fetchPhoto(from: photoInfo.url!) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.labelTitle.text = photoInfo.title
                //self?.title = photoInfo.title
                self?.descriptionLabel.text = photoInfo.explanation
            }
        }
    }
}

func presentUI(apod: DataImage, data: Data){
    DispatchQueue.main.async {
        self.imageView.image = UIImage(data: data)
        self.labelTitle.text = apod.title
        self.labelDescriptions.text = apod.explanation
        
    }
}

extension SecondScreenViewController: UITextFieldDelegate {
    
}
