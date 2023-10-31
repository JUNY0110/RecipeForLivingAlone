//
//  ViewModel.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import UIKit

final class FoodListViewModel {

    // MARK: - Properties
    
    let networkManager: NetworkManager

    // MARK: Output
    
    private var foodDatum = [Food]() {
        didSet {
            onCompletedData(foodDatum)
        }
    }
    
    var onCompletedData: ([Food]) -> () = { _ in }
    
    // MARK: - Init
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        makeFoodDatum()
    }
    
    // MARK: - Methods
    
    private func makeFoodDatum() {
        for mainURL in APIEnvironment.mainURLs {
            networkManager.makeFoodData(urlString: APIEnvironment.baseURL + mainURL) { result in
                switch result {
                case .success(let food):
                    self.foodDatum.append(food)
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    func filteredFoodDatum(with word: String) -> [Food] {
        let filteredDatum = foodDatum.filter { $0.title.contains(word) }
        return filteredDatum.isEmpty ? foodDatum : filteredDatum
    }
}
