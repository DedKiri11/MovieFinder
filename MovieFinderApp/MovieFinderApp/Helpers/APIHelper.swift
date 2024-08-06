//
//  APIHelper.swift
//  MovieFinderApp
//
//  Created by Кирилл Зезюков on 22.07.2024.
//
//

import Foundation
import Combine

class APIHelper {
    enum APIErrors: Error {
        case badURL(String)
        case badRequest(String)
        case dataMissing(String)
    }
    
    enum APIMethods: String {
        case loadMovie = "films/collections"
        case searchMovie = "films"
        case loadStaff = "staff"
    }
    
    enum APIBaseURL: String {
        case movie = "https://kinopoiskapiunofficial.tech/api/v2.2/"
        case staff = "https://kinopoiskapiunofficial.tech//api/v1/"
    }
    
    private static let apiKey = APIConstants.apiKey
    
    static func sendRequest(method: APIMethods, for baseURL: APIBaseURL, params: [String: String] = [:]) -> Future<Data, Error> {
        let requestBody = baseURL.rawValue + method.rawValue + getParams(params)
        guard let url = URL(string: requestBody) else {
            return Future { promise in
                promise(.failure(APIErrors.badURL("Bad URL")))
            }
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return Future { promise in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    promise(.failure(APIErrors.badRequest(error.localizedDescription)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    promise(.failure(APIErrors.badRequest("Invalid response from server")))
                    return
                }
                
                guard let data = data else {
                    promise(.failure(APIErrors.dataMissing("No data received")))
                    return
                }
                
                promise(.success(data))
            }
            task.resume()
        }
    }
    
    private static func getParams(_ params: [String: String]) -> String {
        guard !params.isEmpty else { return "" }
        
        var result: [String] = []
        
        result = params.map { $0.key + "=" + $0.value }
        
        return "?" + result.joined(separator: "&")
    }
}
