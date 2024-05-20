//
//  CountryUIItem.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 20/05/2024.
//

import Foundation

enum CountryUIItem: Identifiable{
    
    case countryUI(CountryItem)
    case headerUI(String)
    
    
    var id: UUID{
        switch self {
        case .countryUI(let countryItem):
            return countryItem.id
            
        case .headerUI:
            var id = UUID()
            return id
        }
    }
    
}
