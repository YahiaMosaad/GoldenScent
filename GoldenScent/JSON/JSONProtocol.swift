//
//  JSONProtocol.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import Foundation
enum JSONError: Error {
    case unexpectedError
    case parsingError
    case noDataFound
    case fileNotFound
}
protocol JSONProtocol {
    func execute<T: Codable> (fileName: String, withModel: T.Type,
                              success: @escaping ((T) -> Void) ,
                              failure: @escaping ((JSONError) -> Void))
}

extension JSONProtocol {
    func execute<T: Codable> (fileName: String, withModel: T.Type,
    success: @escaping ((T) -> Void) ,
    failure: @escaping ((JSONError) -> Void)) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
//                print(jsonData)
                    success(jsonData)
            } catch {
                print("error:\(error)")
                failure(JSONError.parsingError)
            }
        }
        else {
            failure(JSONError.fileNotFound)
        }
    }
}
