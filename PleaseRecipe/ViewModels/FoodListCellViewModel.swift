//
//  FoodListCellViewModel.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/14/23.
//

import UIKit

final class FoodListCellViewModel {
    
    // MARK: - Properties
    
    let networkManager: NetworkManager
    
    // MARK: Input
    
    var imageURL: String? {
        didSet {
            loadImage()
        }
    }
    
    // MARK: Ouput
    
    private var foodImage: UIImage? {
        didSet {
            onCompleted(foodImage)
        }
    }
    
    var onCompleted: (UIImage?) -> () = { _ in }
    
    // MARK: - Init
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: - Methods
    
    func loadImage() {
        networkManager.loadImage(imageURL: imageURL) { [weak self] image in
            self?.foodImage = image
        }
    }
}
