//
//  CountryRepository.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import Foundation
import Combine

class CountryRepository: CountryRepositoryProtocol{
    
    private let remoteDataSource: CountryRemoteDataSourceProtocol
    private let localDataSource: CountryLocalDataSourceProtocol
    
    init(remoteDataSource: CountryRemoteDataSourceProtocol, localDataSource: CountryLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getCountries1() -> AnyPublisher<[CountryItem], Error> {
        return remoteDataSource.fetchCountries()
            .handleEvents(receiveOutput: {countries in
                self.localDataSource.saveCountries(countries)
            })
            .catch{_ in
                self.localDataSource.fetchCountries()
                    .setFailureType(to: Error.self)
                
            }
            .eraseToAnyPublisher()
    }
    func getCountries() -> AnyPublisher<[CountryItem], Error> {
          return remoteDataSource.fetchCountries()
              .handleEvents(receiveSubscription: { _ in
                  print("Started fetching countries")
              }, receiveOutput: { countries in
                  self.localDataSource.saveCountries(countries)
              }, receiveCompletion: { completion in
                  switch completion {
                  case .finished:
                      print("Finished fetching countries successfully")
                  case .failure(let error):
                      print("Failed to fetch countries with error: \(error)")
                  }
              })
              .catch { error in
                  print("Error fetching from remote, falling back to local data source")
                  return self.localDataSource.fetchCountries()
                      .handleEvents(receiveOutput: { countries in
                          print("Received countries from local: \(countries)")
                      })
                      .setFailureType(to: Error.self)
              }
              .eraseToAnyPublisher()
      }
    
    
}
