//
//  DataPictureViewController.swift
//  APOD
//
//  Created by Irina on 04.11.2023.
//

import UIKit

protocol DataPicturePresenterProtocol {
    func viewDidLoad()
}

class DataPictureViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: DataPicturePresenterProtocol?
    
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
        //imageView.backgroundColor = .yellow
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
    
    //MARK: - Private functions
    
    private func setupViews() {
        view.addSubview(labelTitle)
        view.addSubview(imageView)
        view.addSubview(labelDescriptions)
        view.addSubview(dateLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelDescriptions.translatesAutoresizingMaskIntoConstraints = false
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
            
            labelDescriptions.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelDescriptions.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            labelDescriptions.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelDescriptions.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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

extension DataPictureViewController: DataPicturePresenterDelegate {
    
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
