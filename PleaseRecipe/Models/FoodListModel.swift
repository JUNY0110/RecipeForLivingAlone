//
//  FoodListModel.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/14/23.
//

import Foundation

enum Section: CaseIterable {
    case food
}

struct Food: Codable, Hashable, Identifiable {
    var id = UUID()
    
    let foodImageURL: String
    let foodName: String
    let summary: String
    let numberOfPerson: String
    let cookingTime: String
    let youtubeURL: String
    var ingredients: [FoodIngredient]
    var seasonings: [FoodSeasoning]
    var cookingOrders: [String]
}

struct FoodIngredient: Hashable, Codable {
    let name: String
    let measuring: String
}

struct FoodSeasoning: Hashable, Codable {
    let name: String
    let measuring: String
}
