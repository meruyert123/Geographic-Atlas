import SwiftUI

struct CountryDetails: View {
    let cca2: String?
    @StateObject private var viewModel: NetworkManager
    @Environment(\.presentationMode) var presentationMode
    
    init(cca2: String?) {
        self.cca2 = cca2
        _viewModel = StateObject(wrappedValue: NetworkManager(cca2Code: cca2))
    }
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) { HStack { Image(systemName: "chevron.left") }}}
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let country = viewModel.countryDetail?.first {
                    if country.flags?.png != nil {
                        AsyncImage(url: URL(string: country.flags!.png)) { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .cornerRadius(8)
                                    .frame(height: 200)
                            }
                            else if phase.error != nil {
                                Color.red
                            }
                            else {
                                ProgressView()
                                    .cornerRadius(8)
                                    .frame(width: 82, height: 48)
                            }
                        }
                    }
                    else  {
                        Color.gray.frame(width: 82, height: 48)
                            .cornerRadius(8)
                    }
                    VStack(alignment: .leading, spacing: 24) {
                        CountryDetailCell(title: "Region:",
                                          detail: country.subregion ?? "", detailArray: nil)
                        CountryDetailCell(title: "Capital:",
                                          detail: "\(country.capital?.first ?? "No capital there.")", detailArray: nil)
                        let capitalCoordinates = country.convertToDMS(latitude: country.capitalInfo?.latlng?[0] ?? 0, longitude: country.capitalInfo?.latlng?[1] ?? 0)
                        CountryDetailCell(title: "Capital coordinates",
                                          detail: "\(capitalCoordinates.0), \(capitalCoordinates.1)", detailArray: nil)
                        CountryDetailCell(title: "Population:",
                                          detail: country.formatPopulation(country.population ?? 0), detailArray: nil)
                        CountryDetailCell(title: "Area:",
                                          detail: "\(country.formatNumber(country.area ?? 0)) km²", detailArray: nil)
                        CountryDetailCell(title: "Currency:",
                                          detail: nil, detailArray: country.getCurrencyList(country: country))
                        CountryDetailCell(title: "Timezones:",
                                          detail: nil, detailArray: country.getTimezones(country: country))
                    }
                    .padding(.horizontal, 16)
                    .navigationTitle(country.name?.common ?? "")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: btnBack)
                }
                else {
                    Color.gray
                }
            }
        }
    }
}

struct CountryDetails_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetails(cca2: "CN")
    }
}
