//
//  Food.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import Foundation

struct Food {
    let titleImageURL: String
    let title: String
    let summary: String
    let numberOfPerson: String
    let cookingTime: String
    let youtubeURL: String
    var ingredientDictionary: [String: String] = [:]
    var cookingOrders: [String]?
}
