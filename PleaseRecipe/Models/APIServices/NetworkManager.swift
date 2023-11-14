//
//  NetworkManager.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import UIKit

import SwiftSoup

protocol NetworkType {
    func makeFoodDatum(completion: @escaping (Food) -> ())
}

final class NetworkManager: NetworkType {

    // MARK: - Properties
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - Methods
    
    func makeFoodDatum(completion: @escaping (Food) -> ()) {
        for mainURL in APIEnvironment.mainURLs {
            self.makeFoodData(urlString: APIEnvironment.baseURL + mainURL) { result in
                switch result {
                case .success(let food):
                    completion(food)
                case .failure(let error):
                    debugPrint(String(reflecting: error))
                }
            }
        }
    }
    
    private func makeFoodData(urlString: String, completion: @escaping (Result<Food, NetworkError>) -> ()) {
        var foodData: Food?
        var ingredientHTMLs: [Element]?
        var recipes: [Element]?
        
        guard let url = URL(string: urlString) else { return completion(.failure(NetworkError.urlError)) }
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return completion(.failure(NetworkError.networkingError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.responseError))
            }
            
            let statusCode = response.statusCode
            
            guard (200..<299) ~= statusCode else {
                return completion(.failure(NetworkError.statusError(statusCode)))
            }
            
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                
                (foodData, ingredientHTMLs, recipes) = try self.parsedData(for: doc,
                                                                           foodData: foodData,
                                                                           ingredientHTMLs: ingredientHTMLs,
                                                                           recipes: recipes)
                foodData = try self.makeIngredientDictionay(with: ingredientHTMLs, foodData: foodData)
                foodData = try self.makeCookingOrders(for: &recipes, foodData: foodData)
                
                guard let foodData = foodData else { throw NetworkError.CrawlingError.foodDataError }
                completion(.success(foodData))
            } catch {
                completion(.failure(NetworkError.parsingError))
            }
        }.resume()
    }
    
    private func parsedData(for doc: Document, 
                            foodData: Food?,
                            ingredientHTMLs: [Element]?,
                            recipes: [Element]?) throws -> (Food?, [Element]?, [Element]?) {
        var foodData = foodData
        var ingredientHTMLs = ingredientHTMLs
        var recipes = recipes
        // html 데이터
        let foodImage = try doc.select("div.centeredcrop")
        let foodDescription = try doc.title()
        
        let numberOfPerson = try doc.select("span.view2_summary_info1")
        let cookingTime = try doc.select("span.view2_summary_info2")
        let ingredientHTMLArray = try doc.getElementById("divConfirmedMaterialArea")?.select("div.ready_ingre3").array()
        let recipeArray = try doc.select("div.view_step").array()
        let youtubeLink = try doc.select("div.iframe_wrap")
        
        // 사용가능 타입 데이터
        let foodImageURL = try foodImage.select("img").attr("src")
        let numberOfPersonText = try numberOfPerson.text()
        let cookingTimeText = try cookingTime.text()
        let youtubeURL = try youtubeLink.select("iframe").attr("org_src")
        
        guard let foodName = FoodName(rawValue: foodDescription) else {
            throw NetworkError.CrawlingError.foodNameError
        }
        
        let foodNameString = String(describing: foodName)
        
        foodData = .init(foodImageURL: foodImageURL,
                         foodName: foodNameString,
                         summary: foodDescription,
                         numberOfPerson: numberOfPersonText,
                         cookingTime: cookingTimeText,
                         youtubeURL: youtubeURL,
                         ingredients: [],
                         seasonings: [],
                         cookingOrders: [])
        
        ingredientHTMLs = ingredientHTMLArray
        recipes = recipeArray
        
        return (foodData, ingredientHTMLs, recipes)
    }
    
    private func makeIngredientDictionay(with ingredientHTMLs: [Element]?, foodData: Food?) throws -> Food?{
        guard let ingredientHTMLs = ingredientHTMLs else { throw NetworkError.CrawlingError.ingredientError }
        var foodData = foodData
        
        for ingredientHTML in ingredientHTMLs {
            let ingredientDatum = try ingredientHTML.select("ul")
            let ingredientInfos = try ingredientDatum.select("li").array()
            
            for info in ingredientInfos {
                let ingredient = try info.select("a[href]").text().replacingOccurrences(of: " 구매", with: "")
                let capacity = try info.select("span.ingre_unit").text()
                
                if let seasoning = Seasoning(rawValue: ingredient) {
                    foodData?.seasonings.append(FoodSeasoning(name: String(reflecting: seasoning), measuring: capacity))
                } else {
                    foodData?.ingredients.append(FoodIngredient(name: ingredient, measuring: capacity))
                }
            }
        }
        return foodData
    }
    
    private func makeCookingOrders(for recipes: inout [Element]?, foodData: Food?) throws -> Food? {
        guard let recipes = recipes else { throw NetworkError.CrawlingError.recipeError }
        var foodData = foodData
        var temp = [String]()
        
        for recipe in recipes {
            let detail = try recipe.select("div.media-body")
            let cookingOrders = detail.array()
            
            for j in 0..<cookingOrders.count {
                let cookingOrder = cookingOrders[j].ownText()
                
                temp.append(cookingOrder)
            }
        }
        foodData?.cookingOrders = temp
        return foodData
    }
}
