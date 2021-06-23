//
//  DetailView.swift
//  MacDemo
//
//  Created by lunkr on 2021/6/22.
//

import SwiftUI

struct SheetView: View {
    
    @Binding var isVisiable: Bool
    
    @Binding var enterText: String
    
    var body: some View {
        VStack {
            Text("Enter some text below...")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            TextField("Eneter the result of the dialog here..", text: $enterText)
                .padding()
            
            HStack {
                Button("Cancel") {
                    self.isVisiable = false
                    self.enterText = "Cancel clicked in sheet"
                }
                Spacer()
                Button("OK") {
                    self.isVisiable = false
                    self.enterText = "OK clicked in sheet"
                }
            }
        }
        .frame(width: 300, height: 150)
    }
}

struct DetailView: View {
    
    var status: HttpStatus
    
    @State private var catImage: NSImage?
    
    @State private var imageIsFlipped = false
    
    @State private var sheetIsShowing = false
    
    @State private var alertIsShowing = false
    
    @State private var dialogResult = ""
    
    private let flipImageMenuItemSelected = NotificationCenter.default
        .publisher(for: .flipImage)
        .receive(on: RunLoop.main)
    
    private let saveImageUrlSelected = NotificationCenter.default.publisher(for: .saveImage)
    
    var body: some View {
        VStack {
            Text("HTTP Status Code:\(status.code)")
            Text(status.title)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            if let image = catImage {
                CatImageView(catImage: image, imageIsFlipped: imageIsFlipped)
            } else {
                Spacer()
                Text("Loading..")
                    .font(.headline)
            }
            Text(dialogResult)
            HStack {
                Button("Alert") {
                    alertIsShowing.toggle()
                }
                Button("Sheet") {
                    sheetIsShowing.toggle()
                }
                Button("Action") {
                    
                }
                Button("File") {
                    self.saveImage()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.getCatImage()
        }
        .onReceive(flipImageMenuItemSelected) { _ in
            self.imageIsFlipped.toggle()
        }
        .onReceive(saveImageUrlSelected) { publisher in
            if let saveUrl = publisher.object as? URL,
               let imageData = self.catImage?.tiffRepresentation {
                if let imageRep = NSBitmapImageRep(data: imageData) {
                    if let saveData = imageRep.representation(using: .jpeg, properties: [:]) {
                        try? saveData.write(to: saveUrl)
                    }
                }
            }
        }
        .sheet(isPresented: $sheetIsShowing) {
            SheetView(isVisiable: $sheetIsShowing, enterText: $dialogResult)
        }
        .alert(isPresented: $alertIsShowing) {
//            Alert(title: Text("Alert"),
//                  message: Text("This is an alert"),
//                  dismissButton: .default(Text("OK")) {
//                dialogResult = "OK clicked in Alert"
//            })
            Alert(title: Text("Alert"),
                  message: Text("This is an alert"),
                  primaryButton: .default(Text("OK"), action: {
                    self.dialogResult = "OK clicked"
                  }),
                  secondaryButton: .cancel({
                    self.dialogResult = "Cancel clicked"
                  }))
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
    
    func saveImage() {
        let panel = NSSavePanel()
        panel.nameFieldLabel = "Save cat image as:"
        panel.nameFieldStringValue = "cat.jpg"
        panel.canCreateDirectories = true
        panel.begin { response in
            if response == NSApplication.ModalResponse.OK, let fileURL = panel.url {
                NotificationCenter.default.post(name: .saveImage, object: fileURL)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(status: HttpStatus.sample)
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
