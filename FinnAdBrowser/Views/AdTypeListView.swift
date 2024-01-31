//
//  AdTypeListView.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 31/01/2024.
//

import SwiftUI

struct AdItemsListView: View {
    
    @ObservedObject var viewModel: AdsViewModel
    let adType: String
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        
        ScrollView {
            contentForAdType(adType)
        }
        .onAppear {
            viewModel.filterAds(by: adType)
        }
        .navigationTitle(adType)
        .background(Color(hex: "#1b1b25"))
        
    }
    
    @ViewBuilder
    private func contentForAdType(_ adType: String) -> some View {
        if viewModel.isGridView(adType) {
            LazyVGrid(columns: columns, spacing: 16) {
                adCardViews
            }.padding(.top, 20)
        } else {
            LazyVStack(spacing: 16) {
                adCardViews
            }.padding(.top, 20)
        }
    }
    
    private var adCardViews: some View {
        ForEach(viewModel.filteredAds) { ad in
            AdCardView(viewModel: viewModel, ad: ad)
        }
    }
}

struct AdCardView: View {
    
    @ObservedObject var viewModel: AdsViewModel
    let ad: AdItemsContainer
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                if let imageUrl = ad.image?.fullImageUrl,
                   let url = URL(string: imageUrl) {
                    CacheAsyncImage(url: url)
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                
                FavoriteButtonView(isFavorite: viewModel.filterFavAds(by: ad.id).isFavorite) {
                    viewModel.updateFavoriteStatus(for: ad.id, isFavorite: !viewModel.filterFavAds(by: ad.id).isFavorite)
                }
                .padding([.top, .trailing], 8)
            }
            
            AdDetailsView(description: ad.description ?? "Unknown Title",
                          location: ad.location ?? "",
                          price: "\(ad.price?.value ?? 0) NOK")
        }
        .background(Color(hex: "#333242"))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

struct FavoriteButtonView: View {
    
    var isFavorite: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .blue : .gray)
                .padding(8)
                .background(Color.white.opacity(0.7))
                .clipShape(Circle())
        }
    }
}

struct AdDetailsView: View {
    
    var description: String
    var location: String
    var price: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(description)
                .font(.body)
                .bold()
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text(location)
                .font(.subheadline)
                .foregroundColor(.white)
            
            Text(price)
                .font(.subheadline)
                .bold()
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .padding(.horizontal, 6)
        .padding(.bottom, 8)
    }
}

#Preview {
    AdItemsListView(viewModel: AdsViewModel(networkService: NetworkService()), adType: "RELESTATE")
}
