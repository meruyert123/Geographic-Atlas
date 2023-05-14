import SwiftUI

struct CountriesList: View {
    @StateObject private var viewModel = NetworkManager()
    @State private var selectedCells: Set<Country> = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.countriesByContinent.keys.sorted(by: <), id: \.self) { continent in
                    Section(header: HStack {
                        Text(continent.uppercased()).foregroundColor(Color.gray)
                        Spacer()
                    }.padding(.leading, 16)) {
                        ForEach(viewModel.countriesByContinent[continent]!) { country in
                            ContentCell(country: country, isExpanded: self.selectedCells.contains(country))
                                .modifier(ScrollCell())
                                .onTapGesture {
                                    if self.selectedCells.contains(country) {
                                        self.selectedCells.remove(country)
                                    }
                                    else {
                                        self.selectedCells.insert(country)
                                    }
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .background(Color("CellColor"))
                                .cornerRadius(12)
                                .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .navigationBarTitle("World Countries")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity)
        }
    }
}

struct ScrollCell: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            content
        }
    }
}

struct CountriesList_Previews: PreviewProvider {
    static var previews: some View {
        CountriesList()
    }
}


