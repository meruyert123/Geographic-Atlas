import Foundation

class NetworkManager: ObservableObject {
    @Published var countries: [Country] = []
    @Published var countryDetail: [Country]?
    @Published var errorMessage: String? = nil
    private let baseURL = "https://restcountries.com/v3.1/all"
    private let detailURL = "https://restcountries.com/v3.1/alpha/"
    
    init() {
        getCountries()
    }
    init(cca2Code: String?) {
        getCountryDetail(cca2Code: cca2Code)
    }
    
    func getCountries() {
        let service = APIService()
        let url = URL(string: baseURL)
        service.fetchCountries(url: url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.errorMessage = error.errorDescription
                    print(error)
                case .success(let countries):
                    self.countries = countries
                }
            }
        }
    }
    
    func getCountryDetail(cca2Code: String?) {
        let service = APIService()
        let uslStr = detailURL+(cca2Code ?? "XK")
        let url = URL(string: uslStr)
        service.fetchCountryDetail(url: url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.errorMessage = error.errorDescription
                    print(error)
                case .success(let countryDetail):
                    self.countryDetail = countryDetail
                }
            }
        }
    }
    
    static func successState() -> NetworkManager {
        let fetcher = NetworkManager()
        return fetcher
    }
}

extension NetworkManager {
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
