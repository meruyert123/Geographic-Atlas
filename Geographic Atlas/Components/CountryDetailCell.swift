import SwiftUI

struct CountryDetailCell: View {
    let title: String
    let detail: String?
    let detailArray: [String]?
    
    var body: some View {
        HStack(spacing: 8) {
            VStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .padding(10)
                Spacer()
            }
            if let detail = detail {
                VStack(alignment: .leading, spacing: 4) {
                    SecondaryTitle(title: title)
                    Text(detail)
                }
            }
            else {
                if let detailArray = detailArray {
                    VStack(alignment: .leading, spacing: 4) {
                        SecondaryTitle(title: "Currencies")
                        VStack(spacing: 4) {
                            ForEach(detailArray, id: \.self) { currency in
                                VStack(spacing: 4) {
                                    Text(currency)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CountryDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailCell(title: "Population", detail: "12345", detailArray: nil)
    }
}
