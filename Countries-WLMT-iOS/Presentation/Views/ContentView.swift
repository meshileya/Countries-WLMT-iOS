//
//  ContentView.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel: CountryViewModel
    
    init(viewModel: CountryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    List(viewModel.countries) { country in
                        VStack(alignment: .leading) {
                            Text(country.countryName)
                                .font(.headline)
                            Text(country.countryCode ?? "NA")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Countries")
            .onAppear {
                viewModel.fetchCountries()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = CountryRepository(remoteDataSource: CountryRemoteDataSource(), localDataSource: CountryLocalDataSource())
        let useCase = GetCountriesUseCase(repository: repository)
        let viewModel = CountryViewModel(getCountriesUseCase: useCase)
        ContentView(viewModel: viewModel)
    }
}
