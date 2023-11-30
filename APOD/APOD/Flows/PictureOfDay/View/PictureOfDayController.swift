//
//  ViewController.swift
//  APOD
//
//  Created by Nata Kuznetsova on 16.10.2023.
//

import UIKit

protocol PictureOfDayProtocol {
    func viewDidLoad()
    func didTapRetryButton()
}

class PictureOfDayController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: PictureOfDayProtocol?
    //     let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(tap(_:)))
    
    //MARK: - Private properties
    
    private var contentView: PictureOfDayContentView = {
        let view = PictureOfDayContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var loadingView: PictureOfDayLoadingView = {
        let view = PictureOfDayLoadingView()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        presenter?.viewDidLoad()
        //     let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(tap(_:)))
    }
    
    //MARK: - Functions
    
    //MARK: - Private functions
    private func setupViews() {
        setupContentView()
        setupLoadingView()
    }
    
    private func setupContentView(){
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLoadingView(){
        view.addSubview(loadingView)
    
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
  

extension PictureOfDayController: PictureOfDayPresenterDelegate {
    func showLoaderState() {
        contentView.isHidden = true
        loadingView.isHidden = false
    }
    
    func showErorState() {
        
    }
    
    func presentImage(apod: DataImage, data: Data){
        contentView.presentImage(apod: apod, data: data)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.contentView.isHidden = false
            self.loadingView.isHidden = true
            }
    }
}
    
    //    @objc func update() {
    //        updateView(friendsList: self.models)
    //    }
    // onTape вызываю преззентер, передаю параметром инфо о картинке.  func addFavorite
    //     @objc func tap(_ recognizer: UIPanGestureRecognizer) {}
    
    
extension PictureOfDayController: PictureOfDayErrorViewDelegate {
    
    func didTapRetryButton() {
        presenter?.didTapRetryButton()
    }
}

