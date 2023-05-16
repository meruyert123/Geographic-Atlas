import SwiftUI

struct CountryDetailCell: View {
    let title: String
    let detailStr: String?
    let detailList: [String]?
    
    var body: some View {
        HStack(spacing: 8) {
            VStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .padding(10)
                Spacer()
            }
            if let detail = detailStr {
                VStack(alignment: .leading, spacing: 4) {
                    SecondaryTitle(title: title)
                    Text(detail)
                }
            }
            else {
                if let detailArray = detailList {
                    VStack(alignment: .leading, spacing: 4) {
                        SecondaryTitle(title: title)
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
        ScrollView {
            VStack(alignment: .leading) {
                CountryDetailCell(title: "Population", detailStr: "12345", detailList: nil)
                CountryDetailCell(title: "Population", detailStr: "12345", detailList: nil)
            }
        }
    }
}
