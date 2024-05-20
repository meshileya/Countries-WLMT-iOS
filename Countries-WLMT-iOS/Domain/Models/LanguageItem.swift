//
//  LanguageItem.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import Foundation

struct LanguageItem: Codable{
    let code: String?
    let iso639_2: String?
    let name: String?
    let nativeName: String?
    
    enum CodingKeys : String, CodingKey{
        case code = "code"
        case iso639_2 = "iso639_2"
        case name = "name"
        case nativeName = "nativeName"
    }
}
