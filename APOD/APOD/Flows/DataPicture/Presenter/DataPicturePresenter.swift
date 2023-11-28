//
//  DataPicturePresenter.swift
//  APOD
//
//  Created by Irina on 26.11.2023.
//

import UIKit

protocol DataPicturePresenterDelegate: AnyObject {
    func updateUI(with photoinfo: DataImage)
    func showAlert()
}

class DataPicturePresenter {
    typealias PresenterDelegate = DataPicturePresenterDelegate & UIViewController
    weak var delegate: PresenterDelegate?
    private var networkService = NetworkService()
    
    private func getImage(){
        networkService.getImage(completion: {[weak self] result in
            switch result {
            case .success(let apod):
                DispatchQueue.global ().async {
                    if let url = URL (string: apod.hdurl ?? ""), let data = try? Data(contentsOf: url){
                        self?.delegate?.updateUI(with: apod)
                    }
                }
            case .failure(_):
                self?.delegate?.showAlert()
            }
        })
    }
}

extension DataPicturePresenter: DataPicturePresenterProtocol {
    func viewDidLoad() {
        getImage()
    }
}
