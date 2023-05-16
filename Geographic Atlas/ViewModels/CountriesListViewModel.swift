import Foundation

class CountriesListViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var error: Error? = nil
    
    private let apiService = APIService()
    private let url = "https://restcountries.com/v3.1/all"
    
    func onMount() {
        let url = URL(string: url)
        
        error = nil

        apiService.fetchCountries(url: url) { [weak self] result in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.error = error
                case .success(let countries):
                    self.countries = countries
                }
            }
        }
    }
}

extension CountriesListViewModel {
    var countriesByContinent: [String: [Country]] {
        var result: [String: [Country]] = [:]
        for country in countries {
            guard let continents = country.continents else {
                continue
            }
            for continent in continents {
                if result[continent] == nil {
                    result[continent] = [country]
                }
                else {
                    result[continent]!.append(country)
                }
            }
        }
        return result
    }
}
