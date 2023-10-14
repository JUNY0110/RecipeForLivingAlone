//
//  FoodListModel.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/14/23.
//

import Foundation

extension FoodListView {
    enum Section: CaseIterable {
        case food
    }
    
    struct Item: Hashable {
        let foodImage: String
        let foodName: String
        let foodDescription: String
    }
}
