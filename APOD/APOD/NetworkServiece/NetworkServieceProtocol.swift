//
//  NetworkServieceProtocol.swift
//  APOD
//
//  Created by Nata Kuznetsova on 25.10.2023.
//

protocol NetworkServiceProtocol {
    func getImage(completion: @escaping (Result<[DataImage], Error>) -> Void) -> Void
}
