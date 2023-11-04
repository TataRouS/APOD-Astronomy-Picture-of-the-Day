//
//  SecondScreenViewController.swift
//  APOD
//
//  Created by Irina on 04.11.2023.
//

import UIKit

class SecondScreenViewController: UIViewController {
    
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.frame = view.bounds
//        scrollView.contentSize = contentSize
//        return scrollView
//    }()
//
//    private var contentSize: CGSize {
//        CGSize(width: view.frame.width, height: view.frame.height * 2)
//    }
//
//    private lazy var contentView: UIView = {
//        let contentView = UIView()
//        contentView.frame.size = contentSize
//        return contentView
//    }()

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
        //imageView.backgroundColor = .yellow
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
        //datePicker.tintColor = .white
        
        datePicker.addTarget(self, action: #selector(datePickerAction(sender:)), for: .valueChanged)
        //datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()
    
    @objc func datePickerAction(sender: UIDatePicker) {
        let selectedDate = dateFormatter.string(from: sender.date)
        
        networkController.fetchPhotoInfo(date: selectedDate) { [weak self] photoInfo in
            if let photoInfo = photoInfo {
                self?.updateUI(with: photoInfo)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setInitView()
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
//                labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                labelTitle.widthAnchor.constraint(equalToConstant: view.frame.size.width),
                //labelTitle.heightAnchor.constraint(equalToConstant: view.frame.size.width/4),
                
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
                imageView.heightAnchor.constraint(equalToConstant: view.frame.size.width),
//                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                     imageView.widthAnchor.constraint(equalToConstant: 200),
//                imageView.heightAnchor.constraint(equalToConstant: 200),
                
                dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
//                dateLabel.widthAnchor.constraint(equalToConstant: 200),
//                dateLabel.heightAnchor.constraint(equalToConstant: 200),
                dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
//                descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
//                descriptionLabel.heightAnchor.constraint(equalToConstant: 200),
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

extension SecondScreenViewController: UITextFieldDelegate {
    
}
