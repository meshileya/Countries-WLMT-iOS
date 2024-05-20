//
//  CountryViewModel.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import Foundation
import Combine

class CountryViewModel: ObservableObject{
    
    @Published var countries: [CountryUIItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let getCountriesUseCase: GetCountriesUseCase
    
    init(getCountriesUseCase: GetCountriesUseCase) {
        self.getCountriesUseCase = getCountriesUseCase
    }
    
    func fetchCountries(){
        isLoading = true
        errorMessage = nil
        
        getCountriesUseCase.execute()
            .sink {completion in
                self.isLoading = false
                
                if case .failure(let error) = completion{
                    self.errorMessage = error.localizedDescription
                }
                
            }receiveValue: { countries in
                self.countries = countries
            }
            .store(in: &cancellables)
    }
}
