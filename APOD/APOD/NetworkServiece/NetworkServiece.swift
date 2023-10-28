//
//  NetworkServiece.swift
//  APOD
//
//  Created by Nata Kuznetsova on 25.10.2023.
//

import Foundation


final class NetworkService: NetworkServiceProtocol {
    
    enum NetworkError: Error {
        case dataError
    }
    private let session = URLSession.shared
    
    //   static var api_key = ""
    //MARK: - General function to get info from Network
    
    func getImage(completion: @escaping (Result<[DataImage], Error>) -> Void ) {
        let url = URL(string: "https//api.nasa.gov/planetary/apod?api_key=2YS2Stqx8sBjzjCbCbiRnaSielwhKXpiEgootxHg")
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
                JSONDecoder().decode(APODModel.self, from: data)
                completion(.success(apod.response.items)) // под ? запись response.items
                print(apod)
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
        .resume()
    }
}
