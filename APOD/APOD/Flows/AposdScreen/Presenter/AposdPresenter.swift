//
//  AposdPresenter.swift
//  APOD
//
//  Created by Nata Kuznetsova on 23.11.2023.
//

import Foundation
import UIKit

protocol AposdPresenterDelegate: AnyObject {
    func presentUI (photoInfo: DataImage)
  //  func showAlert()
}

typealias AposdPresDelegate = AposdPresenterDelegate & UIViewController

class AposdPresenter {
    
    weak var delegate: AposdPresDelegate?
    private var networkService = NetworkService()
    
    public func updateUI(with photoInfo: DataImage){
        networkService.fetchPhoto(completion: {[weak self] result in
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
    
    func updateUI(with photoInfo: DataImage) {
        networkController.fetchPhoto(from: photoInfo.url!) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.labelTitle.text = photoInfo.title
                //self?.title = photoInfo.title
                self?.descriptionLabel.text = photoInfo.explanation
            }
        }
    }
    
    func getPhotoByDate(date: selectedDate){
        networkService.fetchPhotoInfo(date: selectedDate) { [weak self] photoInfo in
            if let photoInfo = photoInfo {
                self?.updateUI(with: photoInfo)
            }
        }
    }
    
    public func setViewDelegate(delegate: AposdPresDelegate){
        self.delegate = delegate
    }
}
