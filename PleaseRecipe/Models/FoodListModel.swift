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

struct Food: Hashable, Codable {
    let foodImageURL: String
    let title: String
    let summary: String
    let numberOfPerson: String
    let cookingTime: String
    let youtubeURL: String
    var ingredients: [String: String] = [:]
    var seasonings: [String: String] = [:]
    var cookingOrders: [String] = []
}
