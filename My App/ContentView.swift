import SwiftUI

struct ContentView: View {
  @State var Images: [UIImage] = []
  @State var CurrentImage = UIImage()
  var body: some View {
    Image(uiImage: CurrentImage)
    .resizable()
    .scaledToFit()
    .statusBarHidden(true)
    .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
      if let SafeCurrentImage = Images.randomElement() {
        withAnimation(.easeInOut) {
          CurrentImage = SafeCurrentImage
        }
      }
    }
    .onAppear {
      Images = GetImages()
      if let SafeCurrentImage = Images.randomElement() {
        CurrentImage = SafeCurrentImage
      }
    }
  }
}

let ImagesPath = "/var/mobile/KEEP"

func GetImages() -> [UIImage] {
  var Images: [UIImage] = []
  for ImageName in GetImageFiles() {
    Images.append(UIImage(contentsOfFile: "\(ImagesPath)/\(ImageName)") ?? UIImage())
  }
  return Images
}

func GetImageFiles() -> [String] {
  do {
    return try FileManager.default.contentsOfDirectory(atPath: ImagesPath).filter({$0.hasSuffix(".jpg")})
  } catch {
    print(error)
    return []
  }
}
