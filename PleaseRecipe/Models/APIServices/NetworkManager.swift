//
//  NetworkManager.swift
//  PleaseRecipe
//
//  Created by 지준용 on 2023/10/08.
//

import Foundation

import SwiftSoup

final class NetworkManager {

    // MARK: - Properties
    
    private var foodData: Food?
    private(set) var foodDatum = [Food]() {
        didSet {
            onCompleted(foodDatum)
        }
    }
    
    var onCompleted: ([Food]) -> () = { _ in }
    
    private var difficultyLevel = ""
    private var ingredientHTMLs: [Element]?
    private var recipes: [Element]?
    
    // MARK: - Init
    
    init() {
        makeFoodDatum()
    }
    
    // MARK: - Methods
    
    private func makeFoodDatum() {
        for mainURL in APIEnvironment.mainURLs {
            makeFoodData(APIEnvironment.baseURL + mainURL)
        }
    }
    
    private func makeFoodData(_ recipeURL: String) {
        guard let url = URL(string: recipeURL) else { return debugPrint(NetworkError.urlError) }
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: url) { _, response, error in
            do {
                guard error == nil else { return debugPrint(error!) }
                guard let response = response as? HTTPURLResponse else { return assertionFailure("응답 실패") }
                let statusCode = response.statusCode
                
                guard (200..<299) ~= response.statusCode else {
                    return try self.errorMessage(statusCode)
                }
                
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                
                try self.parsedData(for: doc)
                try self.makeIngredientDictionay(with: self.ingredientHTMLs)
                try self.makeCookingOrders(for: self.recipes)
                
                guard let foodData = self.foodData else { return }
                self.foodDatum.append(foodData)
            } catch {
                debugPrint(error)
            }
        }.resume()
    }
    
    private func parsedData(for doc: Document) throws {
        // html 데이터
        let titleImage = try doc.select("div.centeredcrop")
        let title = try doc.title()
        let summary = try doc.select("div.view2_summary_in")
        
        let numberOfPerson = try doc.select("span.view2_summary_info1")
        let cookingTime = try doc.select("span.view2_summary_info2")
        let difficultyLevel = try doc.select("span.view2_summary_info3")
        let ingredientHTMLs = try doc.getElementById("divConfirmedMaterialArea")?.select("div.ready_ingre3").array()
        let recipes = try doc.select("div.view_step").array()
        let youtubeLink = try doc.select("div.iframe_wrap")
        
        // 사용가능 타입 데이터
        let titleImageURL = try titleImage.select("img").attr("src")
        let summaryText = try summary.text()
        let numberOfPersonText = try numberOfPerson.text()
        let cookingTimeText = try cookingTime.text()
        let difficultyLevelText = try difficultyLevel.text()
        let youtubeURL = try youtubeLink.select("iframe").attr("org_src")
        
        
        foodData = .init(titleImageURL: titleImageURL,
                         title: title,
                         summary: summaryText,
                         numberOfPerson: numberOfPersonText,
                         cookingTime: cookingTimeText,
                         youtubeURL: youtubeURL)
        
        self.difficultyLevel = difficultyLevelText
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
                
                foodData?.ingredientDictionary[ingredient] = capacity
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
    
    private func errorMessage(_ statusCode: Int) throws {
        switch statusCode {
        case 300..<399: debugPrint(NetworkError.redirectionError)
        case 400..<499: debugPrint(NetworkError.clientError)
        case 500..<599: debugPrint(NetworkError.serverError)
        default: debugPrint(NetworkError.unknownError)
        }
    }
}

// MARK: - Nested Types

extension NetworkManager {
    
    // MARK: Error
    
    enum NetworkError: Error, CustomDebugStringConvertible {
        case succeess
        case redirectionError
        case clientError
        case serverError
        case urlError
        case unknownError
        
        var debugDescription: String {
            switch self {
            case .succeess: "네트워크 연결 성공"
            case .redirectionError: "리다이렉션 에러"
            case .clientError: "클라이언트 에러"
            case .serverError: "서버 에러"
            case .urlError: "URL 에러"
            case .unknownError: "알수없는 오류"
            }
        }
    }

    enum ParsingError: Error, CustomDebugStringConvertible {
        case titleImageError
        case titleError
        case summaryError
        case numberOfPersonError
        case cookingTimeError
        case difficultyLevelError
        case ingredientHTMLsError
        case recipesError
        case youtubeLinkError
        
        var debugDescription: String {
            switch self {
            case .titleImageError: "타이틀 이미지 파싱 에러"
            case .titleError: "요리 이름 파싱 에러"
            case .summaryError: "요리 요약설명 파싱 에러"
            case .numberOfPersonError: "기준 인원수 파싱 에러"
            case .cookingTimeError: "조리 시간 파싱 에러"
            case .difficultyLevelError: "난이도 파싱 에러"
            case .ingredientHTMLsError: "재료 파싱 에러"
            case .recipesError: "조리법 파싱 에러"
            case .youtubeLinkError: "유튜브 링크 파싱 에러"
            }
        }
    }
}