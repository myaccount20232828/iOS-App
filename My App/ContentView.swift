import SwiftUI

struct ContentView: View {
  var body: some View {
    ForEach(GetImages(), id: \.self) { image in {
      Image(uiimage: image)
    }
  }
}

let ImagesPath = "/var/mobile/KEEP"

func GetImages() -> [UIImage] {
  var Images: [UIImage] = []
  for ImageName in GetImageFiles() {
    Images.append(UIImage(contentsOfFile: "\(ImagesPath)/\(ImageName)"))
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
