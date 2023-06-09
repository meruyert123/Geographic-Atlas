import SwiftUI

struct CountryDetails: View {
    let cca2: String?
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: CountryDetailsViewModel
    
    init(cca2: String?) {
        self.cca2 = cca2
    }

    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let country = viewModel.country?.first {
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
                                          detailStr: country.subregion ?? "There is no region.", detailList: nil)
                        CountryDetailCell(title: "Capital:",
                                          detailStr: "\(country.capital?.first ?? "There is no capital.")", detailList: nil)
                        if let capitalInfo = country.capitalInfo?.latlng,
                           let capitalCoordinates = country.convertToDMS(latitude: capitalInfo[0],
                                                                         longitude: capitalInfo[1]),
                           !capitalInfo.isEmpty {
                            OpenStreetMapCountryDetailCell(title: "Capital coordinates",
                                                           detailStr: "\(capitalCoordinates.0), \(capitalCoordinates.1)",
                                                           detailUrl: country.maps?.openStreetMaps)
                        }
                        else {
                            OpenStreetMapCountryDetailCell(title: "Capital coordinates",
                                                           detailStr: nil,
                                                           detailUrl: nil)
                        }
                        CountryDetailCell(title: "Population:",
                                          detailStr: country.formatPopulation(country.population ?? 0), detailList: nil)
                        CountryDetailCell(title: "Area:",
                                          detailStr: "\(country.formatNumber(country.area ?? 0)) km²", detailList: nil)
                        CountryDetailCell(title: "Currency:",
                                          detailStr: nil, detailList: country.getCurrencyList(country: country))
                        CountryDetailCell(title: "Timezones:",
                                          detailStr: nil, detailList: country.getTimezones(country: country))
                    }
                    .navigationTitle(country.name?.common ?? "")
                } else if viewModel.error == nil {
                    ProgressView()
                } else {
                    Text("Something went wrong.")
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
        .onAppear {
            if cca2 != nil {
                viewModel.onMount(cca2Code: cca2!)
            }
        }
        .onDisappear {
            viewModel.onUnmount()
        }
    }
}

struct CountryDetails_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetails(cca2: "HM")
            .environmentObject(CountryDetailsViewModel())
    }
}
