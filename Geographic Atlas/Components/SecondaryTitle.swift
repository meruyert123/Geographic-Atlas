import SwiftUI

struct SecondaryTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(Color("secondaryTitleColor"))
    }
}

struct SecondaryTitle_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryTitle(title: "68 mln")
    }
}
