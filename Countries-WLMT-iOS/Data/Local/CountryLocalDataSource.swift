//
//  CountryLocalDataSource.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import Foundation
import Combine

protocol CountryLocalDataSourceProtocol {
    func saveCountries (_ countries: [CountryItem])
    func fetchCountries() -> AnyPublisher<[CountryItem], Never>
}


class CountryLocalDataSource: CountryLocalDataSourceProtocol{
    private let userDefaults = UserDefaults.standard
    
    func saveCountries(_ countries: [CountryItem]) {
        if let encoded = try? JSONEncoder().encode(countries){
            userDefaults.set(encoded, forKey: "countries")
        }
    }
    
    func fetchCountries() -> AnyPublisher<[CountryItem], Never> {
        guard let data = userDefaults.data(forKey: "countries"),
              let countries = try? JSONDecoder().decode([CountryItem].self, from: data) else{
            return Just([]).eraseToAnyPublisher()
            
        }
        return Just(countries).eraseToAnyPublisher()
    }
    
}
