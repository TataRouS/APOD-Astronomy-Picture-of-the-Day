//
//  ApodScreenBuilder.swift
//  APOD
//
//  Created by Nata Kuznetsova on 23.11.2023.
//

import Foundation
import UIKit

struct  PictureOfDayBuilder {
    static func build() -> UIViewController {
        let presenter = PictureOfDayPresenter(networkService: NetworkService(),
                                              fileCacheService: DataStoreService())
        let viewController = PictureOfDayController()
        viewController.presenter = presenter
        presenter.delegate = viewController
        return viewController
    }
}
