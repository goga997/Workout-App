//
//  NetworkRequest.swift
//  TrainingApp
//
//  Created by Grigore on 18.07.2023.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {}
    
    func requestData(latitude: String, longitude: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = "12803d2d9f0e6755fcfdec566863924b"
//        let latitude = "44.4471042"
//        let longitude = "26.0621868"
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
    
}
