import Foundation

struct Country: Codable, Identifiable, Hashable  {
    var id = UUID()
    let name: Name?
    let capital: [String]?
    let population: Int?
    let currencies: [String: Currency]?
    let flags: Flags?
    let area: Float?
    let region: String?
    let timezones: [String]?
    let cca2: String?
    let subregion: String?
    let capitalInfo: CapitalInfo?
    let continents: [String]?
    let maps: Maps?
    
    enum CodingKeys: String, CodingKey {
        case name
        case capital
        case population
        case currencies
        case flags
        case area
        case region
        case timezones
        case cca2
        case subregion
        case capitalInfo
        case continents
        case maps
    }
    
    struct Flags: Codable, Hashable {
        let png: String
    }
    
    struct CapitalInfo: Codable, Hashable {
        let latlng: [Double]?
    }
    
    struct Name: Codable, Hashable {
        let common: String
    }
    
    struct Currency: Codable, Hashable {
        let name: String?
        let symbol: String?
    }
    
    struct Maps: Codable, Hashable {
        let openStreetMaps: String?
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(capital)
        hasher.combine(population)
        hasher.combine(currencies)
        hasher.combine(flags)
        hasher.combine(area)
        hasher.combine(region)
        hasher.combine(timezones)
        hasher.combine(cca2)
        hasher.combine(subregion)
        hasher.combine(capitalInfo)
        hasher.combine(continents)
    }
}

extension Country {
    
    func formatPopulation(_ population: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        var number = Double(population)
        let suffix: String
        
        switch number {
        case 1000..<1000000:
            suffix = " k"
            number /= 1000
        case 1000000..<1000000000:
            suffix = " mln"
            number /= 1000000
        case 1000000000...:
            suffix = " b"
            number /= 1000000000
        default:
            suffix = ""
        }
        
        formatter.maximumFractionDigits = number.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 1
        let formattedNumber = formatter.string(from: NSNumber(value: number)) ?? ""
        return formattedNumber + suffix
    }
    
    func convertToDMS(latitude: Double, longitude: Double) -> (String, String) {
        let latDegrees = Int(latitude)
        let latMinutes = Int((latitude - Double(latDegrees)) * 60)
        
        let lonDegrees = Int(longitude)
        let lonMinutes = Int((longitude - Double(lonDegrees)) * 60)
        
        let latString = String(format: "%d°%d'", latDegrees, latMinutes)
        let lonString = String(format: "%d°%d'", lonDegrees, lonMinutes)
        
        return (latString, lonString)
    }
    
    func formatNumber(_ number: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        let formattedNumber = formatter.string(from: NSNumber(value: number)) ?? ""
        return formattedNumber
    }
    
    func getTimezones(country: Country) ->[String]{
        var resultCurrencyList: [String] = []
        if let countryCurrency = country.timezones  {
            for i in countryCurrency {
                resultCurrencyList.append(i)
            }
        }
        return !resultCurrencyList.isEmpty ? resultCurrencyList : []
    }
    
    func getCurrencyList(country: Country) -> [String]? {
        var resultCurrencyList: [String] = []
        if let countryCurrency = country.currencies  {
            for i in countryCurrency {
                var current: String = ""
                if let name = i.value.name {
                    if !name.isEmpty {
                        current = current + "\(name)"
                    }
                }
                if let symbol = i.value.symbol {
                    if !symbol.isEmpty {
                        current = current + " (\(symbol))"
                    }
                }
                current = current + " (\(i.key))"
                resultCurrencyList.append(current)
            }
        }
        return !resultCurrencyList.isEmpty ? resultCurrencyList : []
    }
    
    static func mockData() -> Country {
        return Country(name: Country.Name.init(common: "Spain"),
                       capital: ["Madrid"],
                       population: 47351567,
                       currencies:["EUR": Currency(name: "Euro", symbol: "€")],
                       flags: Country.Flags(png: "https://flagcdn.com/w320/es.png"),
                       area: 1888,
                       region: "Europe",
                       timezones: ["UTC", "UTC+01:00"],
                       cca2: "ES",
                       subregion: "Southern Europe",
                       capitalInfo: Country.CapitalInfo(latlng: [40.4, -3.68]),
                       continents: ["Europe"],
                       maps: Country.Maps(openStreetMaps: "https://www.openstreetmap.org/relation/1311341"))
    }
}
