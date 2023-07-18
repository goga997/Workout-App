//
//  NetworkDataFetch.swift
//  TrainingApp
//
//  Created by Grigore on 18.07.2023.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchData(latitude: String, longitude: String, response: @escaping (WeatherModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(latitude: latitude, longitude: longitude) { result in
            
            switch result {
            case .success(let data):
                 do
                {
                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                    response(weather, nil)
                }
                catch let jsonError
                {
                    print("failed to decode JSON", jsonError)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                response(nil, error)
            }
        }
    }
}
