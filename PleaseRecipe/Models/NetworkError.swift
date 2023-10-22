//
//  NetworkError.swift
//  PleaseRecipe
//
//  Created by 지준용 on 10/22/23.
//

import Foundation

enum NetworkError: Error, CustomDebugStringConvertible {
    case networkingError
    case responseError
    
    case redirectionError
    case clientError
    case serverError
    case urlError
    
    case parsingError
    case unknownError
    
    var debugDescription: String {
        switch self {
        case .networkingError: "네트워크 에러"
        case .responseError: "URL 응답 에러"
        case .redirectionError: "리다이렉션 에러"
        case .clientError: "클라이언트 에러"
        case .serverError: "서버 에러"
        case .urlError: "URL 에러"
        case .parsingError: "파싱 에러"
        case .unknownError: "알수없는 오류"
        }
    }
}
