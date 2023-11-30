//
//  ApodPresenter.swift
//  APOD
//
//  Created by Nata Kuznetsova on 17.11.2023.
//

import UIKit

protocol PictureOfDayPresenterDelegate: AnyObject {
    func presentImage(apod: DataImage, data: Data)
    func showAlert()
    //func favorite()
}

class PictureOfDayPresenter {
    typealias PresenterDelegate = PictureOfDayPresenterDelegate & UIViewController
    weak var delegate: PresenterDelegate?
    private var networkService = NetworkService()
    
    private func getImage(){
        networkService.getImage(completion: {[weak self] result in
            switch result {
            case .success(let apod):
                DispatchQueue.global ().async {
                    if let url = URL (string: apod.hdurl ?? ""), let data = try? Data(contentsOf: url){
                        self?.delegate?.presentImage(apod: apod, data: data)
                    }
                }
            case .failure(_):
                self?.delegate?.showAlert()
            }
        })
    }
    //func addFavorite{
    //func favorite()
    //FileFavoriteCache.addPicture()
    //}
}



extension PictureOfDayPresenter: PictureOfDayProtocol {
    func viewDidLoad() {
        getImage()
    }
}
