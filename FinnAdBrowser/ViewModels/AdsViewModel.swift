//
//  AdsViewModel.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 30/01/2024.
//

import Foundation

class AdsViewModel: ObservableObject {
    
    private let networkService: AdsServiceProtocol
    private var favoritesRepository = FavoritesRepository()
    
    @Published var ads: [AdItemsContainer] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var adTypes: [AdType] = []
    @Published var filteredAds: [AdItemsContainer] = []
    var favoriteIds: Set<String> = Set()
    
    init(networkService: AdsServiceProtocol) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchAdsList() async {
        isLoading = true
        errorMessage = nil
      
        do {
            let fetchedAds = try await networkService.fetchAdsList()
            let favoriteIds = Set(favoritesRepository.load().map { $0.id })
           
            ads = fetchedAds.map { ad in
                var modifiedAd = ad
                modifiedAd.isFavorite = favoriteIds.contains(ad.id)
                return modifiedAd
            }
            
            let types = Set(ads.map { $0.adType }).sorted()
            adTypes = types.map { AdType(name: $0) }
            
        } catch {
            errorMessage = "Failed to fetch ads: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func filterAds(by adType: String) {
        filteredAds = ads.filter { $0.adType == adType }
    }
    
    func filterFavAds(by adId: String) -> AdItemsContainer {
        ads.first { $0.id == adId }!
    }
    
    @MainActor
    func updateFavoriteStatus(for adId: String, isFavorite: Bool)  {
        
        guard let index = ads.firstIndex(where: { $0.id == adId }) else { return }
        ads[index].isFavorite = isFavorite

        if isFavorite {
            var currentFavorites = favoritesRepository.load()
            currentFavorites.append(ads[index])
            favoritesRepository.save(items: currentFavorites)
        } else {
            var currentFavorites = favoritesRepository.load()
            currentFavorites.removeAll(where: { $0.id == adId })
            favoritesRepository.save(items: currentFavorites)
        }
    }
    
    @MainActor
    func loadFavorites() {
        
        let loadedFavorites = favoritesRepository.load()
        let favoriteIds = Set(loadedFavorites.map { $0.id })

         for (index, ad) in ads.enumerated() {
             ads[index].isFavorite = favoriteIds.contains(ad.id)
         }
    }
    
    var realEstateAds: [AdItemsContainer] {
        ads.filter { $0.adType == "REALESTATE" }
    }
    
    var favorites: [AdItemsContainer] {
        ads.filter { $0.isFavorite }
    }
    
    func isGridView(_ adType: String) -> Bool {
        return adType == "BAP"
    }
    
    func hasFavorites(for adType: String) -> Bool {
        if adType == "All" {
            return !favorites.isEmpty
        } else {
            return favorites.contains { $0.adType == adType }
        }
    }
    
    func filteredFavorites(by adType: String) -> [AdItemsContainer] {
        favorites.filter { adType == "All" || $0.adType == adType }
    }
}
