//
//  CountryRemoteDataSource.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import Foundation
import Combine

let BASE_URL = "https://gist.githubusercontent.com/peymano-wmt/"

protocol CountryRemoteDataSourceProtocol {
    func fetchCountries() -> AnyPublisher<[CountryItem], Error>
}

class CountryRemoteDataSource: CountryRemoteDataSourceProtocol{
    private let url = URL(string: "\(BASE_URL)32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json")!


    func fetchCountries() -> AnyPublisher<[CountryItem], Error> {
           return URLSession.shared.dataTaskPublisher(for: url)
               .handleEvents(receiveSubscription: { _ in
                   print("Started fetching countries")
               }, receiveOutput: { data, response in
                   print("Received data: \(data)")
                   if let httpResponse = response as? HTTPURLResponse {
                       print("Received HTTP response: \(httpResponse.statusCode)")
                   }
               }, receiveCompletion: { completion in
                   switch completion {
                   case .finished:
                       print("Finished fetching countries successfully")
                   case .failure(let error):
                       print("Failed to fetch countries with error: \(error)")
                   }
               })
               .map { $0.data }
               .decode(type: [CountryItem].self, decoder: JSONDecoder())
               .receive(on: DispatchQueue.main)
               .eraseToAnyPublisher()
       }
}
