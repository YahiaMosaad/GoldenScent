//
//  JSONManager.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import Foundation

class JSONManager: JSONProtocol {
    func fetcRowsDataFrom(fileName: String,
                          success: ((Rows) -> Void)?,
                                failure: ((JSONError) -> Void)?) {
        execute(fileName: fileName, withModel: Rows.self, success: { (result) in
            success!(result)
        }) { (error) in
            failure!(error)
        }
    }
}
