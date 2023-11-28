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
        let viewController = PictureOfDayController()
        let presenter = PictureOfDayPresenter()
        viewController.presenter = presenter
        presenter.delegate = viewController
        return viewController
    }
}
