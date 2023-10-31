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
    
    let width: CGFloat
    
    // MARK: Ouput
    
    private var foodImage: UIImage? {
        didSet {
            onCompleted(foodImage)
        }
    }
    
    var onCompleted: (UIImage?) -> () = { _ in }
    
    // MARK: - Init
    
    init(networkManager: NetworkManager, width: CGFloat) {
        self.networkManager = networkManager
        self.width = width
    }
    
    // MARK: - Methods
    
    func loadImage() {
        networkManager.loadImage(imageURL: imageURL, width: width) { [weak self] image in
            self?.foodImage = image
        }
    }
    
    func loadImage(imageURL: String?, completion: @escaping (UIImage?) -> ()) {
        guard let urlString = imageURL,
              let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                guard urlString == url.absoluteString else { return }
                
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } catch {
                debugPrint(error)
            }
        }
    }
}
