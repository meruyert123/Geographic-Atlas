import SwiftUI

class ImageLoader: ObservableObject {
    let url: String?
    
    @Published var image: UIImage? = nil
    @Published var errorMessage: String? = nil
    
    init(url: String?) {
        self.url = url
        fetch()
    }
    
    func fetch() {
        
        guard image == nil else {
            return
        }
        
        guard let url = url, let fetchURL = URL(string: url) else {
            errorMessage = APIError.invalidURL.errorDescription
            print("h1 \(self.errorMessage)")
            return
        }
        
        let request = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    print("h2 \(self.errorMessage)")
                }
                else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    self.errorMessage = APIError.serverError(statusCode: response.statusCode).localizedDescription
                    print("h3 \(self.errorMessage) \(response.statusCode)")
                }
                else if let data = data, let image = UIImage(data: data) {
                    self.image = image
                }
                else {
                    self.errorMessage = (error as? APIError)?.localizedDescription ?? APIError.unknown(error!).localizedDescription
                    print("h4 \(self.errorMessage)")
                }
            }
        }
        task.resume()
    }
}
