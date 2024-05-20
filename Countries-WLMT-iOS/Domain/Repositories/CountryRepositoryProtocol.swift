//
//  CountryRepositoryProtocol.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import Foundation
import Combine

protocol CountryRepositoryProtocol{
    func getCountries() -> AnyPublisher<[CountryItem], Error>
}
