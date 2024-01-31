//
//  FavoritesView.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 31/01/2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject var viewModel: AdsViewModel
    @State private var selectedAdType: String = "All"
    
    var body: some View {
        VStack {
            filterMenu
            if viewModel.hasFavorites(for: selectedAdType) {
                favoritesList
            } else {
                EmptyStateView(message: "No favorites found in this category. Explore more to find ads you love!")
            }
        }
        .background(Color(hex: "#1b1b25"))
        .onAppear {
            viewModel.loadFavorites()
        }
    }
    
    private var favoritesList: some View {
        
        ScrollView {
            VStack(spacing: 16) {
                ForEach(filteredFavorites, id: \.id) { ad in
                    AdCardView(viewModel: viewModel, ad: ad)
                }
            }
        }
    }
    
    private var filterMenu: some View {
        
        HStack {
            Spacer()
            MenuView(viewModel: viewModel, selectedAdType: $selectedAdType)
        }
        .padding(.horizontal)
    }
    
    private var filteredFavorites: [AdItemsContainer] {
        viewModel.filteredFavorites(by: selectedAdType)
    }
}

struct FavoritesListView: View {
    
    var favorites: [AdItemsContainer]
    var viewModel: AdsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(favorites, id: \.id) { ad in
                    AdCardView(viewModel: viewModel, ad: ad)
                }
            }
        }
    }
}

struct MenuView: View {
    
    var viewModel: AdsViewModel
    @Binding var selectedAdType: String
    
    var body: some View {
        Menu {
            Button("All", action: { selectedAdType = "All" })
            ForEach(viewModel.adTypes, id: \.name) { adType in
                Button(adType.name, action: { selectedAdType = adType.name })
            }
        } label: {
            MenuLabel(selectedAdType: selectedAdType)
        }
    }
}

struct MenuLabel: View {
    
    var selectedAdType: String
    
    var body: some View {
        HStack {
            Text(selectedAdType)
            Image(systemName: "chevron.down")
        }
        .foregroundColor(.white)
        .padding()
        .background(Color(hex: "#333242"))
        .cornerRadius(8)
    }
}

struct EmptyStateView: View {
    
    var message: String
    
    var body: some View {
        Spacer()
        Text(message)
            .multilineTextAlignment(.center)
            .foregroundColor(.white.opacity(0.6))
            .padding()
        Spacer()
    }
}

#Preview {
    FavoritesView(viewModel: AdsViewModel(networkService: NetworkService()))
}
