//
//  FavoritePicturePresenter.swift
//  APOD
//
//  Created by Nata Kuznetsova on 29.11.2023.
//

import UIKit

protocol FavoritePresenterDelegate: AnyObject {
    func reloadData()
}

class FavoritePresenter {
    typealias PresenterDelegate = PictureOfDayPresenterDelegate & UIViewController
    weak var delegate: PresenterDelegate?
    private var networkService = NetworkService()
    private var fileCache = FileFavoriteCache()
   
    
    func getImage(){
       let models = fileCache.fetchPictures()
    
            }
        }
    
