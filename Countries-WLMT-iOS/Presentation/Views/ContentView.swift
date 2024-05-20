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
    @State private var searchText: String = ""
    
    init(viewModel: CountryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack{
//                UISearchBar()
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                    } else {
                        List(viewModel.countries) { uiItem in
                            
                            switch uiItem{
                            case .countryUI(let countryItem):
                                VStack(alignment: .leading) {
                                    HStack{
                                        Text("Country: \(countryItem.countryName)")
                                            .font(.headline)
                                        Spacer()
                                        Text("Code: \(countryItem.countryCode ?? "NA")")
                                            .font(.subheadline)
                                    }
                                    Text("Capital: \(countryItem.capital ?? "NA")")
                                        .font(.headline)
                                }
                            case .headerUI(let header):
                                Text("\(header)")
                                    .font(.largeTitle)
                                
                            }
                            
                            
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
