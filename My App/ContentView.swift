import SwiftUI

struct ContentView: View {
  var body: some View {
    Text(GetImageFiles().description)
  }
}

func GetImageFiles() -> [String] {
  do {
    return try FileManager.default.contentsOfDirectory(atPath: "/var/mobile/KEEP").filter({$0.hasSuffix(".jpg")})
  } catch {
    print(error)
    return []
  }
}
