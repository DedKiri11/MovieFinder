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
    enum APIErrors: String {
        case badURL
        case badRequest
        case dataMissing
    }

    enum APIMethods: String {
        case loadMovie = "films/collections"
        case loadStaff = "staff"
    }

    private static let apiKey = "05ce83b1-4538-4d91-834b-122e6287360e"
    private static let baseURL = "https://kinopoiskapiunofficial.tech/api/v2.2/"
    static let passthrough = PassthroughSubject<Data, Never>()
    static var canсellables =  Set<AnyCancellable>()

    static func sendRequest(method: APIMethods, params: [String: String] = [:]) {
        let requestBody = baseURL + method.rawValue + getParams(params)
        guard let url = URL(string: requestBody) else {
            print(APIErrors.badURL.rawValue)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            if let error = error {
                print(APIErrors.badRequest.rawValue + ": \(error)")
                return
            }

            guard let data = data else {
                print(APIErrors.dataMissing.rawValue)
                return
            }

            self.passthrough.send(data)
        }

        task.resume()
    }

    private static func getParams(_ params: [String: String]) -> String {
        guard !params.isEmpty else { return "" }

        var result: [String] = []

        result = params.map { $0.key + "=" + $0.value }

        return "?" + result.joined(separator: "&")
    }
}
