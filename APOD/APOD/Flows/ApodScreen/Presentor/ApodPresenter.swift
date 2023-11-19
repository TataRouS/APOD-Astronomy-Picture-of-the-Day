//
//  ApodPresenter.swift
//  APOD
//
//  Created by Nata Kuznetsova on 17.11.2023.
//

import Foundation
import UIKit

protocol ApodPresenterDelegate: AnyObject {
    func presentImage(apod: DataImage, data: Data)
    func showAlert()
}

typealias PresenterDelegate = ApodPresenterDelegate & UIViewController

class ApodPresenter {
    
    weak var delegate: PresenterDelegate?
    private var networkService = NetworkService()
    
    public func getImage(){
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
    
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
}
