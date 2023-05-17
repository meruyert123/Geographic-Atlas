import SwiftUI

struct ContentCell: View {
    
    let country: Country
    let isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12)  {
            HStack {
                if country.flags?.png != nil {
                    ImageLoadingView(url: country.flags!.png)
                }
                else  {
                    Color.gray.frame(width: 82, height: 48)
                        .cornerRadius(8)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(country.name?.common ?? "There is no country name.")
                        .lineLimit(1)
                        .font(.headline)
                    Text(country.capital?.first ?? "There is no capital.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.system(size: 22, weight: .regular))
            }
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 4) {
                            SecondaryTitle(title: "Population:")
                            Text(country.formatPopulation(country.population ?? 0))
                        }
                        HStack(spacing: 4){
                            SecondaryTitle(title: "Area:")
                            Text("\(country.formatNumber(country.area ?? 0)) km²")
                        }
                        HStack(alignment: .top, spacing: 4) {
                            SecondaryTitle(title: "Currencies:")
                            Text("\(country.getCurrencyList(country: country).first ?? "No currency.")")
                                .lineLimit(1)
                        }
                    }
                    HStack(alignment: .top) {
                        Spacer()
                        NavigationLink {
                            CountryDetails(cca2: country.cca2 ?? "")
                                .padding(.top, 16)
                                .padding(.horizontal, 16)
                        } label: {
                            Text("Learn More")
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                }
            }
        }.contentShape(Rectangle())
    }
}


struct ContentCell_Previews: PreviewProvider {
    static var previews: some View {
        ContentCell(country: Country.mockData(), isExpanded: true)
    }
}
