//
//  DataPictureViewController.swift
//  APOD
//
//  Created by Irina on 04.11.2023.
//

import UIKit

protocol DatePicturePresenterProtocol {
    func viewDidLoad()
}

class DatePictureController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: DatePicturePresenterProtocol?
    
    //MARK: - Private properties
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var labelTitleDate: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.text = "Select a date"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        //label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        return label
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
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    
    private var dateLabel: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, 
                             action: #selector(datePickerAction(sender:)),
                             for: .valueChanged)
        return datePicker
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
        setInitView()
        presenter?.viewDidLoad()
    }
    
    //MARK: - Functions
    
    @objc func datePickerAction(sender: UIDatePicker) {
        let selectedDate = dateFormatter.string(from: sender.date)
        
        networkController.fetchPhotoInfo(date: selectedDate) { [weak self] photoInfo in
            if let photoInfo = photoInfo {
                self?.updateUI(with: photoInfo)
            }
        }
    }
    
    //MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(labelTitle)
        view.addSubview(imageView)
        view.addSubview(labelTitleDate)
        view.addSubview(dateLabel)
        view.addSubview(button)
        view.addSubview(scrollView)
        scrollView.addSubview(labelDescriptions)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelDescriptions.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        labelTitleDate.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            labelTitleDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelTitleDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labelTitleDate.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            button.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: labelTitleDate.bottomAnchor, constant: 20),
            labelTitle.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.size.width),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            labelDescriptions.topAnchor.constraint(equalTo: scrollView.topAnchor),
            labelDescriptions.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            labelDescriptions.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            labelDescriptions.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            labelDescriptions.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    let networkController = NetworkService()
    let dateFormatter = DateFormatter()
    
    private func setInitView() {
        labelDescriptions.text = ""
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateLabel.maximumDate = .now
    }
}

extension DatePictureController: DatePicturePresenterDelegate {
    
    func updateUI(with photoinfo: DataImage){
        networkController.fetchPhoto(from: photoinfo.url!) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.labelTitle.text = photoinfo.title
                self?.labelDescriptions.text = photoinfo.explanation
            }
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
