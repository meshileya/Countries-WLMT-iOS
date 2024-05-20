//
//  CurrencyItem.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import Foundation

struct CurrencyItem: Codable{
    let code: String?
    let name: String?
    let symbol: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
        case symbol = "symbol"
    }
}
