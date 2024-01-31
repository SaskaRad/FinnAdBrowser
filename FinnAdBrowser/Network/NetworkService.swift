//
//  NetworkService.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 29/01/2024.
//

import Foundation

protocol AdsServiceProtocol {
    func fetchAdsList() async throws -> [AdItemsContainer]
}

class NetworkService: AdsServiceProtocol {
    
    func fetchAdsList() async throws -> [AdItemsContainer] {
        let urlString = "https://gist.githubusercontent.com/baldermork/6a1bcc8f429dcdb8f9196e917e5138bd/raw/discover.json"
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkingError.invalidResponse
            }

            let adResponse = try JSONDecoder().decode(AdDTO.self, from: data)
            return adResponse.items
        } catch {
            throw NetworkingError.dataProcessingError
        }
    }
}

enum NetworkingError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case dataProcessingError
}

class MockNetworkService: AdsServiceProtocol {
    
    var mockData: [AdItemsContainer]?
    var mockError: Error?

    func fetchAdsList() async throws -> [AdItemsContainer] {
        if let error = mockError {
            throw error
        }
        return mockData ?? []
    }
}
