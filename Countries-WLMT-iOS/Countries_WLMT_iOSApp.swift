//
//  Countries_WLMT_iOSApp.swift
//  Countries-WLMT-iOS
//
//  Created by tech on 19/05/2024.
//

import SwiftUI

@main
struct Countries_WLMT_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = CountryRepository(remoteDataSource: CountryRemoteDataSource(), localDataSource: CountryLocalDataSource())
            let useCase = GetCountriesUseCase(repository: repository)
            let viewModel = CountryViewModel(getCountriesUseCase: useCase)
            ContentView(viewModel: viewModel)
        }
    }
}
