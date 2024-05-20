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
    
    func execute() -> AnyPublisher<[CountryItem], Error>{
        return repository.getCountries()
    }
}
