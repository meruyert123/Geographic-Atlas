import SwiftUI

struct ContentCell: View {
    
    let country: Country
    let isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12)  {
            HStack {
                if country.flags?.png != nil {
                    AsyncImage(url: URL(string: country.flags!.png)) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFill()
                                .cornerRadius(8)
                                .frame(width: 82, height: 48)
                                .clipped()
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
                VStack(alignment: .leading, spacing: 4) {
                    Text(country.name?.common ?? "No")
                        .font(.headline)
                    ForEach(country.capital ?? [], id: \.self) { capital in
                        Text(capital)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
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
                            Title(title: country.formatPopulation(country.population ?? 0))
                        }
                        HStack(spacing: 4){
                            SecondaryTitle(title: "Area:")
                            Title(title: "\(country.formatNumber(country.area ?? 0)) km²")
                        }
                        HStack(alignment: .top, spacing: 4) {
                            SecondaryTitle(title: "Currencies:")
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(country.getCurrencyList(country: country), id: \.self) { currency in
                                    VStack(spacing: 4) {
                                        Text(currency)
                                    }
                                }
                            }
                        }
                    }
                    HStack(alignment: .top) {
                        Spacer()
                        NavigationLink {
                            CountryDetails(cca2: country.cca2 ?? "")
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
