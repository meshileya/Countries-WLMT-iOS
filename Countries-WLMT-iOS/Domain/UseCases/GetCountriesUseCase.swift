//
//  GetCountriesUseCase.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import Foundation
import Combine

class GetCountriesUseCase{
    private let repository: CountryRepositoryProtocol
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[CountryUIItem], Error>{
        let countries = repository.getCountries()
            .map{countries in
                var countryLetter: Character? = nil
                
                return countries.sorted(by: {$0.countryName < $1.countryName}).map{ country -> CountryUIItem in
                    let countryChar = country.countryName.first ?? Character("")
                    if countryLetter == nil || countryChar != countryLetter{
                        countryLetter = countryChar
                        return .headerUI("\(countryChar)")
                    }
                    return .countryUI(country)
                }
                
                
            }.eraseToAnyPublisher()
        return countries
        
    }
}
