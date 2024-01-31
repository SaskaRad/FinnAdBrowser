//
//  AppearanceConfiguration.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 30/01/2024.
//

import UIKit
import SwiftUI

class AppearanceConfigurator {
    
    static func configure() {
        customizeNavigationBarAppearance()
    }
    
    private static func customizeNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color(hex: "#1b1b25"))

        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.shadowColor = nil

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
