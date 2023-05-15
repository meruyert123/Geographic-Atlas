import SwiftUI

@main
struct Geographic_AtlasApp: App {
    @StateObject var countriesListViewModel = CountriesListViewModel()
    
    var body: some Scene {
        WindowGroup {
            CountriesList()
                .environmentObject(countriesListViewModel)
        }
    }
}
