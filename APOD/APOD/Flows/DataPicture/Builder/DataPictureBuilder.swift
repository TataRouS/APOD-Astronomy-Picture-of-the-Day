//
//  DataPictureBuilder.swift
//  APOD
//
//  Created by Irina on 25.11.2023.
//

import UIKit

struct DataPictureBuilder {
    static func build() -> UIViewController {
        let viewController = DataPictureViewController()
        let presenter = DataPicturePresenter()
        viewController.presenter = presenter
        presenter.delegate = viewController
        return viewController
    }
}
