import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case serverError(statusCode: Int)
    case invalidData
    case unknown(Error)
    case url(URLError?)
    case parsing(DecodingError?)

    var errorDescription: String {
        switch self {
        case .invalidURL:
            return ""
        case .serverError(_):
            return "There was an error with the server. Please try again later"
        case .invalidData:
            return "The coin data is invalid. Please try again later"
        case .unknown(let error):
            return error.localizedDescription
        case .url(let error):
            return  error?.localizedDescription ?? "Something went wrong"
        case .parsing(let error):
            return "Parsing error \(error?.localizedDescription ?? "")"
        }
    }
}

