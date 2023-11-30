//
//  PictureOfDayErrorView.swift
//  APOD
//
//  Created by Nata Kuznetsova on 30.11.2023.
//

import Foundation
import UIKit

protocol PictureOfDayErrorViewDelegate: AnyObject {
    func didTapRetryButton()
}
    
class PictureOfDayErrorView: UIView {
    
    var delegate: PictureOfDayPresenterDelegate?
    
    
}

// label  ошибка загрузки данных из сети
//кнопка попробовать снова
//(через делегат просим презентер заного загрузить)
//протокол подключаю
//target: delegat:didTapRetryButton()
