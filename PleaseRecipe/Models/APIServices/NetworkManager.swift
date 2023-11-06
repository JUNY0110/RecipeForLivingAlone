//
//  NetworkManager.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import UIKit

import SwiftSoup

protocol NetworkType {
    func makeFoodData(urlString: String, completion: @escaping (Result<Food, NetworkError>) -> ())
    func loadImage(imageURL: String?, width: CGFloat, completion: @escaping (UIImage?) -> ())
}

final class NetworkManager: NetworkType {

    // MARK: - Properties
    
    private var foodData: Food?
    private var ingredientHTMLs: [Element]?
    private var recipes: [Element]?
    
    // MARK: - Methods
    
    func makeFoodData(urlString: String, completion: @escaping (Result<Food, NetworkError>) -> ()) {
        guard let url = URL(string: urlString) else { return completion(.failure(NetworkError.urlError)) }
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: url) { _, response, error in
            guard error == nil else {
                return completion(.failure(NetworkError.networkingError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.responseError))
            }
            
            let statusCode = response.statusCode
            
            guard (200..<299) ~= statusCode else {
                return completion(.failure(self.statusError(statusCode)))
            }
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                
                try self.parsedData(for: doc)
                try self.makeIngredientDictionay(with: self.ingredientHTMLs)
                try self.makeCookingOrders(for: self.recipes)
                
                guard let foodData = self.foodData else { return }
                completion(.success(foodData))
            } catch {
                completion(.failure(NetworkError.parsingError))
            }
        }.resume()
    }
    
    func loadImage(imageURL: String?, width: CGFloat, completion: @escaping (UIImage?) -> ()) {
        guard let urlString = imageURL,
              let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                guard urlString == url.absoluteString else { return }
                
                DispatchQueue.main.async {
                    var image = UIImage(data: data)
                    image = image?.resize(newWidth: width)
                    completion(image)
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    private func parsedData(for doc: Document) throws {
        // html 데이터
        let foodImage = try doc.select("div.centeredcrop")
        let foodDescription = try doc.title()
        
        let numberOfPerson = try doc.select("span.view2_summary_info1")
        let cookingTime = try doc.select("span.view2_summary_info2")
        let ingredientHTMLs = try doc.getElementById("divConfirmedMaterialArea")?.select("div.ready_ingre3").array()
        let recipes = try doc.select("div.view_step").array()
        let youtubeLink = try doc.select("div.iframe_wrap")
        
        // 사용가능 타입 데이터
        let foodImageURL = try foodImage.select("img").attr("src")
        let numberOfPersonText = try numberOfPerson.text()
        let cookingTimeText = try cookingTime.text()
        let youtubeURL = try youtubeLink.select("iframe").attr("org_src")
        
        guard let foodName = FoodName(rawValue: foodDescription) else { return }
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
        
        self.ingredientHTMLs = ingredientHTMLs
        self.recipes = recipes
    }
    
    private func makeIngredientDictionay(with ingredientHTMLs: [Element]?) throws {
        guard let ingredientHTMLs = ingredientHTMLs else { return }
        
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
    }
    
    private func makeCookingOrders(for recipe: [Element]?) throws {
        guard let recipes = self.recipes else { return }
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
    }

    private func statusError(_ statusCode: Int) -> NetworkError {
        switch statusCode {
        case 300..<399:
            return NetworkError.redirectionError
        case 400..<499: 
            return NetworkError.clientError
        case 500..<599: 
            return NetworkError.serverError
        default: 
            return NetworkError.unknownError
        }
    }
}
