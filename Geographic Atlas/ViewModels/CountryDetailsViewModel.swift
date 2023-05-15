import Foundation

class CountryDetailsViewModel: ObservableObject {
    @Published var country: [Country]?
    @Published var error: Error? = nil
    
    private let path = "https://restcountries.com/v3.1/alpha/"
    
    func onMount(cca2Code: String) {
        let apiService = APIService()
        let fullPath = path + cca2Code
        let url = URL(string: fullPath)
        
        error = nil

        apiService.fetchCountryDetail(url: url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.error = error
                    print(error)
                case .success(let data):
                    self.country = data
                }
            }
        }
    }
    
    func onUnmount() {
        self.country = nil
    }
}
