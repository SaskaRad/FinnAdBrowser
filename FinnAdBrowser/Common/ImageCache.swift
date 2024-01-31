//
//  ImageCache.swift
//  FinnAdBrowser
//
//  Created by Saska Radosavljevic on 30/01/2024.
//

import UIKit
import SwiftUI

class ImageCache {
    
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    private var url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func load() {
        guard let url = self.url else {
            self.image = nil
            return
        }
        
        if let cachedImage = ImageCache.shared.image(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    ImageCache.shared.setImage(downloadedImage, forKey: url.absoluteString)
                    self.image = downloadedImage
                } else {
                    self.image = nil
                }
            }
        }.resume()
    }
}

struct CacheAsyncImage: View {
    
    @StateObject private var loader: ImageLoader
    
    init(url: URL?) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }
        }
        .onAppear(perform: loader.load)
    }
}
