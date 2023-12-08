//
//  ApodPresenter.swift
//  APOD
//
//  Created by Nata Kuznetsova on 17.11.2023.
//

import UIKit

protocol PictureOfDayPresenterDelegate: AnyObject {
    func showState(_ newState: PictureOfDayScreenState)
}

enum PictureOfDayError: Error {
    case unknownError
    case networkError(Error)
}

class PictureOfDayPresenter {
    typealias PresenterDelegate = PictureOfDayPresenterDelegate & UIViewController
    
    // MARK: - Properties
    
    weak var delegate: PresenterDelegate?
    
    // MARK: - Private properties
    
    private let networkService: NetworkServiceProtocol
    private let dataStoreService: DataStoreServiceProtocol

    private var currentImageModel: DataImage?
    
    // MARK: - Construction
    
    init(networkService: NetworkServiceProtocol,
         fileCacheService: DataStoreServiceProtocol) {
        self.networkService = networkService
        self.dataStoreService = fileCacheService
    }
    
    // MARK: - Private functions
    
    private func requestData() {
        delegate?.showState(.loading)

        networkService.getImage { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let apod):
                processSuccessResponse(apod)
            case .failure(let error):
                processFailureResponse(error)
            }
        }
    }
    
    private func processSuccessResponse(_ responseModel: DataImage) {
        guard let strongHDUrl = responseModel.hdurl,
              let url = URL (string: strongHDUrl),
              let data = try? Data(contentsOf: url) else {
            delegate?.showState(.error(.unknownError))
            return
        }

        var isFavorite = false
        if let strongDate = responseModel.date {
            isFavorite = dataStoreService.isFavorite(date: strongDate)
        }
        currentImageModel = responseModel
        
        let contentModel = PictureOfDayViewModel(isFavorite: isFavorite,
                                                 image: UIImage(data: data),
                                                 title: responseModel.title,
                                                 description: responseModel.explanation)
        delegate?.showState(.loaded(contentModel))
    }
    
    private func processFailureResponse(_ error: Error) {
        delegate?.showState(.error(.networkError(error)))
    }
}

extension PictureOfDayPresenter: PictureOfDayProtocol {
    func didTapFavoriteButton() {
        guard let strongCurrentImageModel = currentImageModel else {
            delegate?.showState(.error(.unknownError))
            return
        }
        
        dataStoreService.addPictureToFavoriteIfNeeded(apod: strongCurrentImageModel)
    }

    func didTapRetryButton() {
        requestData()
    }
    
    func viewDidLoad() {
        requestData()
    }
}
