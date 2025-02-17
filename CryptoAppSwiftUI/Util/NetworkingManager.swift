//
//  NetworkingManager.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 9.02.2025.
//

import Foundation
import Combine

class NetworkingManager{
    
    enum NetworkingError: LocalizedError{
        case badUrlResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badUrlResponse(url : let url):
                return "Bad URL Response \(url)"
            case .unknown:
                return "Unknown Error"
            }
        }
    }
    
    static func download(url:URL)->AnyPublisher<Data,Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap ({try handleURLResponse(output: $0,url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output : URLSession.DataTaskPublisher.Output,url : URL) throws-> Data{
        guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkingError.badUrlResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion : Subscribers.Completion<Error>){
        switch completion {
        case .failure(let error):
            NetworkingError.unknown
        case .finished:
            break
        }
    }
}


//URLSession.shared.dataTaskPublisher(for: url)
//    .subscribe(on: DispatchQueue.global(qos: .default))
//    .tryMap {(output)->Data in
//        guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw URLError(.badServerResponse)
//        }
//        return output.data
//    }
//    .receive(on: DispatchQueue.main)
//    .decode(type: [CoinModel].self, decoder: JSONDecoder())
//    .sink(receiveCompletion: { completion in
//        switch completion {
//        case .failure(let error):
//            print("Error: \(error)")
//        case .finished:
//            break
//        }
//        
//    },
//    receiveValue:{ [weak self] coins in
//        self?.allCoins = coins
//        self?.coinSubsctiption?.cancel()
//    })
