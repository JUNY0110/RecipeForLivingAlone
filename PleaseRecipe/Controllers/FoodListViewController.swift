//
//  FoodListViewController.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import UIKit

final class FoodListViewController: UIViewController {

    // MARK: - Properties
    
    private let networkManager = NetworkManager()
    private var foodDatum = [Food]() {
        didSet {
            // TODO: - 데이터 리로드
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        fetchFoodDatum()
    }
    
    // MARK: - Methods
    
    private func fetchFoodDatum() {
        networkManager.onCompleted = {_ in
            self.foodDatum = self.networkManager.foodDatum
        }
    }
}

