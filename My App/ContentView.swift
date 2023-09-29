import SwiftUI

struct ContentView: View {
  var body: some View {
    ForEach(GetImages(), id: \.self) { CurrentImage in {
      Image(uiImage: CurrentImage)
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
