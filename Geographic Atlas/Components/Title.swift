import SwiftUI

struct Title: View {
    let title: String
    
    var body: some View {
        Text(title)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title(title: "Population")
    }
}
