import SwiftUI

@main
struct Geographic_AtlasApp: App {
    @StateObject var countriesListViewModel = CountriesListViewModel()
    @StateObject var countryDetailsViewModel = CountryDetailsViewModel()
    
    var body: some Scene {
        WindowGroup {
            CountriesList()
                .environmentObject(countriesListViewModel)
                .environmentObject(countryDetailsViewModel)
        }
    }
}
