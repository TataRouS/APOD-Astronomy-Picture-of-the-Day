//
//  FavoritePicturePresenter.swift
//  APOD
//
//  Created by Nata Kuznetsova on 29.11.2023.
//

import UIKit

protocol FavoritePresenterDelegate: AnyObject {
    func showError(error: Error, date: Date)
    func updateView(apod: [DataImage])
}

class FavoritePresenter {
    typealias PresenterDelegate = FavoritePresenterDelegate & UIViewController
    weak var delegate: PresenterDelegate?
    private var networkService = NetworkService()
    private var fileCache = FileFavoriteCache()
    
}

extension FavoritePresenter: FavoritePresenterProtocol {
    func fetchPictures() -> [DataImage] {
        let models = fileCache.fetchPictures()
        return models
    }
    
}
