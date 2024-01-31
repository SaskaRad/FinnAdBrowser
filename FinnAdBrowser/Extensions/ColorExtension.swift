//
//  ColorExtension.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 30/01/2024.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        let cleanedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: cleanedHex).scanHexInt64(&int)
        
        let r, g, b, a: Double
        switch cleanedHex.count {
        case 3:
            r = Double((int >> 8)       * 17) / 255.0
            g = Double((int >> 4 & 0xF) * 17) / 255.0
            b = Double((int & 0xF)      * 17) / 255.0
            a = 1.0
        case 6:
            r = Double(int >> 16)       / 255.0
            g = Double(int >> 8 & 0xFF) / 255.0
            b = Double(int & 0xFF)      / 255.0
            a = 1.0
        case 8: 
            a = Double(int >> 24)       / 255.0
            r = Double(int >> 16 & 0xFF) / 255.0
            g = Double(int >> 8 & 0xFF) / 255.0
            b = Double(int & 0xFF)      / 255.0
        default:
            (r, g, b, a) = (0, 0, 0, 1)
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
