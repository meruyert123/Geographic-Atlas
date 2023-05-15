import SwiftUI

struct ImageLoadingView: View {
    @StateObject var imageLoader: ImageLoader
    
    init(url: String?) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(8)
                    .frame(width: 82, height: 48)
                    .clipped()
            }
            else if imageLoader.errorMessage != nil {
                Color("CellColor")
                    .cornerRadius(8)
                    .frame(width: 82, height: 48)
            }
            else {
                ProgressView()
                    .cornerRadius(8)
                    .frame(width: 82, height: 48)
            }
        }
        .onAppear {
            imageLoader.fetch()
        }
    }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(url: "https://image.jpg")
    }
}
