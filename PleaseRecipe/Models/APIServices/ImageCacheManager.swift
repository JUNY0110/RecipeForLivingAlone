//
//  ImageCacheManager.swift
//  PleaseRecipe
//
//  Created by 지준용 on 11/11/23.
//

import UIKit

protocol ImageCacheType: AnyObject {
    func loadImage(imageURL: String?, completion: @escaping (UIImage?) -> ())
}

final class ImageCacheManager: ImageCacheType {
    
    // MARK: - Properties
    
    static let shared = ImageCacheManager()
    private let cachedImages = NSCache<NSURL, UIImage>()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Methods
    
    private func cachedImage(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    func loadImage(imageURL: String?, completion: @escaping (UIImage?) -> ()) {
        guard let urlString = imageURL,
              let url = NSURL(string: urlString) else { return }

        if let cachedImage = self.cachedImage(url: url) {
            return DispatchQueue.main.async {
                completion(cachedImage)
            }
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url as URL)
                guard urlString == url.absoluteString else { return }

                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    self.cachedImages.setObject(image, forKey: url)
                    completion(image)
                }
            } catch {
                print(error)
            }
        }
    }
}
