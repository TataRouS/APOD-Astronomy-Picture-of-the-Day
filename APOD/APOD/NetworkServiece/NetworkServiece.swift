//
//  NetworkServiece.swift
//  APOD
//
//  Created by Nata Kuznetsova on 25.10.2023.
//

import Foundation
import UIKit


final class NetworkService: NetworkServiceProtocol {
    
    
    enum NetworkError: Error {
        case dataError
    }
    private let session = URLSession.shared
    
    //   static var api_key = ""
    //MARK: - General function to get info from Network
    
    func getImage(completion: @escaping (Result<DataImage, Error>) -> Void ) {
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=2YS2Stqx8sBjzjCbCbiRnaSielwhKXpiEgootxHg")
        guard let url else {
            return
        }
        
        session.dataTask(with: url) { (data, response,error) in
            guard let data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let apod = try
                JSONDecoder().decode(DataImage.self, from: data)
                completion(.success(apod))
                print(apod)
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
        .resume()
    }
    
    func fetchPhotoInfo(date: String, completion: @escaping (DataImage?) -> Void) {
        let baseUrl = URL(string: "https://api.nasa.gov/planetary/apod")!
        let query: [String: String] = [
            "api_key": "AsQLm83QtpFevfrIgCd3cJhRs1dHGSCmJ3lYRZrr",
            "date": date
        ]
        let queryUrl = baseUrl.withQueries(query)!
        
        URLSession.shared.dataTask(with: queryUrl) { data, _, _ in
            let jsonDecoder = JSONDecoder()
            
            if let data = data, let photoInfoObject = try? jsonDecoder.decode(DataImage.self, from: data) {
                completion(photoInfoObject)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func fetchPhoto(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
