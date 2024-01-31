//
//  FinnAdBrowserApp.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 29/01/2024.
//

import SwiftUI

@main
struct FinnAdBrowserApp: App {
    
    init() {
        AppearanceConfigurator.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AdTypesView(viewModel: AdsViewModel(networkService: NetworkService()))
        }
    }
}
