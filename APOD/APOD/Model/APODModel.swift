//
//  APODModel.swift
//  APOD
//
//  Created by Irina on 27.10.2023.
//

import Foundation

struct APODModel: Decodable {
    let copyright, date, explanation: String?
    let hdurl: String?
    let mediaType, serviceVersion, title: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
