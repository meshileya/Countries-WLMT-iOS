//
//  CountryItem.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import Foundation

class CountryItem: Codable, Identifiable{
    var id = UUID()
    let capital: String?
    let countryCode: String?
    let currency: CurrencyItem?
    let demonym: String?
    let flag: String?
    var languageItem: LanguageItem?
    let countryName: String
    let countryRegion: String
    
    enum CodingKeys: String, CodingKey{
        case capital = "capital"
        case countryCode = "code"
        case currency = "currency"
        case demonym = "demonym"
        case flag = "flag"
        case languageItem = "language"
        case countryName = "name"
        case countryRegion = "region"
    }
}
