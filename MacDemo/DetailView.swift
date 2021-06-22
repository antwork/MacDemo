//
//  DetailView.swift
//  MacDemo
//
//  Created by lunkr on 2021/6/22.
//

import SwiftUI

struct DetailView: View {
    
    var status: HttpStatus
    
    @State private var catImage: NSImage?
    
    var body: some View {
        VStack {
            Text("HTTP Status Code:\(status.code)")
            Text(status.title)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            if let image = catImage {
                CatImageView(catImage: image, imageIsFlipped: false)
            } else {
                Spacer()
                Text("Loading..")
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.getCatImage()
        }
    }
    
    func getCatImage() {
        let url = status.imageUrl
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                DispatchQueue.main.async {
                    self.catImage = NSImage(data: data)
                }
            }
        }
        task.resume()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(status: HttpStatus.sample)
    }
}


class Prefs: ObservableObject {
    
    @Published var showCopyright: Bool = UserDefaults.standard.bool(forKey: "showCopyright") {
        didSet {
            UserDefaults.standard.set(self.showCopyright, forKey: "showCopyright")
        }
    }
}


struct CatImageView: View {
    @EnvironmentObject var prefs: Prefs
    
    let catImage: NSImage
    let imageIsFlipped: Bool
    
    var body: some View {
        Image(nsImage: catImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotation3DEffect(Angle(degrees: imageIsFlipped ? 180 : 0),
                              axis: (x: 0, y: 1, z: 0))
            .animation(.default)
            .overlay(
                Text("Copyright © https://http.cat")
                    .padding(6)
                    .font(.caption)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                ,alignment: .bottomTrailing)
    }
}
