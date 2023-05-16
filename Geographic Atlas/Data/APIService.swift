import Foundation

struct APIService {
    
    func fetchCountries(url: URL?, completion: @escaping(Result<[Country], APIError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if let error = error as? URLError {
                completion(.failure(.url(error)))
            }
            else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(.parsing(error as? DecodingError)))
            }
        })
        task.resume()
    }
    
    func fetchCountryDetail(url: URL?, completion: @escaping(Result<[Country], APIError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if let error = error as? URLError {
                completion(.failure(.url(error)))
            }
            else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let country = try decoder.decode([Country].self, from: data)
                completion(.success(country))
            } catch {
                completion(.failure(.parsing(error as? DecodingError)))
            }
        })
        task.resume()
    }
}
