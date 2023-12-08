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
    func didTapFavoriteButton()
}

enum PictureOfDayScreenState {
    case error(PictureOfDayError)
    case loading
    case loaded(PictureOfDayViewModel)
}

class PictureOfDayController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: PictureOfDayProtocol?
    
    //MARK: - Private properties
    
    private var contentView = PictureOfDayContentView()
    private var loadingView = PictureOfDayLoadingView()
    private var errorView = PictureOfDayErrorView()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
    }
    
    //MARK: - Private functions
    
    private func setupViews(){
        view.backgroundColor = .white

        contentView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(errorView)
        view.addSubview(loadingView)
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
  
extension PictureOfDayController: PictureOfDayPresenterDelegate {
    func showState(_ newState: PictureOfDayScreenState) {
        DispatchQueue.main.async { [weak self] in
            self?.resetState()
        
            switch newState {
            case .loading:
                self?.processLoadingState()
            case .error(let error):
                self?.processErrorState(error)
            case .loaded(let model):
                self?.processLoadedState(model)
            }
        }
    }
    
    func processLoadingState() {
        loadingView.isHidden = false
        loadingView.setActivityIndicatorAnimating(isAnimating: true)
    }
    
    func processErrorState(_ error: PictureOfDayError) {
        errorView.isHidden = false
        
        switch error {
        case .unknownError:
            let errorViewModel = PictureOfDayErrorViewModel(title: "Не получилось разобрать\nответ от сервера",
                                                            subtitle: nil,
                                                            buttonTitle: "Попробовать снова")
            errorView.setupData(errorViewModel)
        case .networkError(let error):
            let errorViewModel = PictureOfDayErrorViewModel(title: "Упс! Произошла ошибка сети",
                                                            subtitle: error.localizedDescription,
                                                            buttonTitle: "Обновить")
            errorView.setupData(errorViewModel)
        }
    }
    
    func processLoadedState(_ contentModel: PictureOfDayViewModel) {
        contentView.setupViewWithModel(contentModel)
        contentView.isHidden = false
    }
    
    func resetState() {
        contentView.isHidden = true
        loadingView.isHidden = true
        errorView.isHidden = true
        
        loadingView.setActivityIndicatorAnimating(isAnimating: false)
    }
}

extension PictureOfDayController: PictureOfDayErrorViewDelegate {
    func didTapRetryButton() {
        presenter?.didTapRetryButton()
    }
}
