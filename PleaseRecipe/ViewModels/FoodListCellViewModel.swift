//
//  FoodListCellViewModel.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/14/23.
//

import UIKit

final class FoodListCellViewModel {
    
    // MARK: - Properties
    
    private let imageCache = ImageCacheManager.shared
    
    // MARK: Input

    var imageURL: String? {
        didSet {
            loadImage()
        }
    }
    
    private let width: CGFloat
    
    // MARK: Ouput

    private var foodImage: UIImage? {
        didSet {
            onCompleted(foodImage)
        }
    }
    
    var onCompleted: (UIImage?) -> () = { _ in }
    
    // MARK: - Init
    
    init(width: CGFloat) {
        self.width = width
    }
    
    // MARK: - Methods
    
    private func loadImage() {
        imageCache.loadImage(imageURL: imageURL) { [weak self] image in
            guard let weakSelf = self else { return }
            weakSelf.foodImage = image
        }
    }
}
