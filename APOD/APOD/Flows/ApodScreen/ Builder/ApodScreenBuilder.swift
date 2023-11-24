//
//  ApodScreenBuilder.swift
//  APOD
//
//  Created by Nata Kuznetsova on 23.11.2023.
//

import Foundation
import UIKit

struct ApodScreenBuilder {
    static func build() -> UIViewController {
        let viewController = ApodViewController()
        let presenter = ApodPresenter()
        viewController.presenter = presenter
        presenter.delegate = viewController
        return viewController
    }
}
