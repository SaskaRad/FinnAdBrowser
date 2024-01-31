//
//  FavoritesRepository.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 30/01/2024.
//

import Foundation

protocol PersistentRepository {
    
    associatedtype Item: Codable
    func save(items: [Item])
    func load() -> [Item]
}

class FavoritesRepository: PersistentRepository {
    
    typealias Item = AdItemsContainer
    
    private var storageUrl: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("favorites.json")
    }
    
    func save(items: [Item]) {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: storageUrl)
        } catch {
            print("Error saving items: \(error)")
        }
    }
    
    func load() -> [Item] {
        guard FileManager.default.fileExists(atPath: storageUrl.path) else {
            return [] 
        }
        
        do {
            let data = try Data(contentsOf: storageUrl)
            return try JSONDecoder().decode([Item].self, from: data)
        } catch {
            print("Error loading items: \(error)")
            return []
        }
    }
}
