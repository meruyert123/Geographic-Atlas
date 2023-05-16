import SwiftUI

struct CountriesList: View {
    @EnvironmentObject var viewModel: CountriesListViewModel
    @State private var selectedCells: Set<Country> = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !viewModel.countries.isEmpty {
                    ForEach(viewModel.countriesByContinent.keys.sorted(by: <), id: \.self) { continent in
                        Section(header: HStack {
                            Text(continent.uppercased()).foregroundColor(Color.gray)
                            Spacer()
                        }.padding(.leading, 16)) {
                            ForEach(viewModel.countriesByContinent[continent]!) { country in
                                ContentCell(
                                    country: country,
                                    isExpanded: self.selectedCells.contains(country)
                                )
                                .modifier(ScrollCell())
                                .onTapGesture {
                                    withAnimation {
                                        if self.selectedCells.contains(country) {
                                            self.selectedCells.remove(country)
                                        } else {
                                            self.selectedCells.insert(country)
                                        }
                                    }
                                }
                                .animation(
                                    .easeIn,
                                    value: self.selectedCells.contains(country)
                                )
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .background(Color("CellColor"))
                                .cornerRadius(12)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }  else if viewModel.error == nil {
                    ProgressView()
                }
                else {
                    Text("Something went wrong.")
                }
            }
            .navigationBarTitle("World Countries")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            viewModel.onMount()
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
            .environmentObject(CountriesListViewModel())
    }
}


