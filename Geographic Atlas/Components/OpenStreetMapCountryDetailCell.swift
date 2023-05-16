import SwiftUI

struct OpenStreetMapCountryDetailCell: View {
    let title: String
    let detailStr: String?
    let detailUrl: String?
    
    var body: some View {
        HStack(spacing: 8) {
            VStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .padding(10)
                Spacer()
            }
            VStack(alignment: .leading, spacing: 4) {
                SecondaryTitle(title: title)
                if let urlString = detailUrl, let validURL = URL(string: urlString), UIApplication.shared.canOpenURL(validURL), let detailStr = detailStr {
                    Button(action: {
                        UIApplication.shared.open(validURL)
                    }) {
                        Text(detailStr)
                            .foregroundColor(.primary)
                    }
                } else if let detailStr = detailStr {
                    Text(detailStr)
                } else {
                    Text("No data.")
                }
            }
        }
    }
}


struct OpenStreetMapCountryDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading) {
                OpenStreetMapCountryDetailCell(title: "Capital coordinates",
                                               detailStr: "51°08′, 71°26′",
                                               detailUrl: "https://www.openstreetmap.org/relation/1311341")
            }
        }
    }
}
