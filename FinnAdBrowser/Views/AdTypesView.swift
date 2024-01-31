//
//  AdTypesView.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 30/01/2024.
//

import SwiftUI

struct AdTypesView: View {
    
    @ObservedObject var viewModel: AdsViewModel
    @State private var isLaunchScreenVisible = true
    
    var body: some View {
        Group {
            if isLaunchScreenVisible {
                LaunchScreenView()
            } else {
                NavigationStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            FinnIconView().frame(maxWidth: .infinity)
                            
                            AdTypesHorizontalGridView(viewModel: viewModel)
                            
                            SectionTitleView(title: "Recommended for you").padding(.top, 30)
                            
                            RealEstateAdsListView(viewModel: viewModel)
                        }
                        .padding(.top, 40)
                    }
                    .background(Color(hex: "#1b1b25"))
                    .ignoresSafeArea()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: FavoritesView(viewModel: viewModel)) {
                                Image(systemName: "heart.fill")
                                    .padding(8)
                                    .background(Circle().fill(Color(hex:"#333242")))
                                    .overlay(Circle().stroke(Color(hex:"#333242"), lineWidth: 1))
                                    .shadow(radius: 2)
                                    .accessibilityLabel("Favorites")
                            }
                        }
                    }
                }
            }
        }.onAppear {
            Task {
                await viewModel.fetchAdsList()
                withAnimation {
                    isLaunchScreenVisible = false
                }
            }
        }
    }
}

struct FinnIconView: View {
    var body: some View {
        Image("finn_icon")
            .resizable()
            .scaledToFit()
            .frame(height: 150)
    }
}

struct SectionTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title.bold())
            .foregroundColor(.white)
            .padding(.horizontal)
    }
}

struct RealEstateAdsListView: View {
    @ObservedObject var viewModel: AdsViewModel
    
    var body: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.realEstateAds) { ad in
                AdCardView(viewModel: viewModel, ad: ad)
            }
        }
    }
}

struct AdTypesHorizontalGridView: View {
    
    @ObservedObject var viewModel: AdsViewModel
    
    let rows: [GridItem] = Array(repeating: .init(.fixed(100)), count: 2)
    let spacing: CGFloat = 16
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: spacing) {
                ForEach(viewModel.adTypes, id: \.name) { adType in
                    VStack(spacing: spacing) {
                        ForEach(0..<1) { _ in
                            NavigationLink(destination: AdItemsListView(viewModel: viewModel, adType: adType.name)) {
                                AdTypeCardView(adType: adType)
                            }
                            .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(Color(hex: "#1b1b25"))
    }
}

struct AdTypeCardView: View {
    
    let adType: AdType
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color(hex: "#333242").opacity(0.2), lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "#333242")))
            
            VStack(spacing: 8) {
                Image(systemName: adType.systemImageName)
                    .font(.largeTitle)
                    .foregroundColor(Color(hex: "#06befc"))
                Text(adType.name.capitalized)
                    .font(.headline)
                    .foregroundColor(Color.white)
            }
        }
        .frame(width: 100, height: 100)
        .padding()
    }
}

#Preview {
    AdTypesView(viewModel: AdsViewModel(networkService: NetworkService()))
}
