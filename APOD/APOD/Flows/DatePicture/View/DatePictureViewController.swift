//
//  DataPictureViewController.swift
//  APOD
//
//  Created by Irina on 04.11.2023.
//


import UIKit

protocol DatePicturePresenterProtocol {
    func viewDidLoad()
    func addFavorite(apod: DataImage)
    func deleteFavorite(apod: DataImage)
    func checkFavoriteByDate(date: String) -> Bool
}

class DatePictureController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: DatePicturePresenterProtocol?
    
    //MARK: - Private properties
    
    private var contentView: DatePictureContentView = {
        let view = DatePictureContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Construction
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has nit been implemented")
    }
    
    //MARK: - Life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        presenter?.viewDidLoad()
    }
    
    //MARK: - Functions
    
    //MARK: - Private functions
    
    private func setupViews() {
        setupContentView()
    }
    
    private func setupContentView() {
        
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
}

extension DatePictureController: DatePicturePresenterDelegate {
    func showAlert() {}
    
    //func showLoaderState(){}
    //func showErorState(){}
    
    func updateUI(with photoinfo: DataImage){
        contentView.updateUI(with: photoinfo)
        
    }
}





