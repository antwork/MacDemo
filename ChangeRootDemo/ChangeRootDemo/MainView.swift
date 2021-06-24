//
//  ContentView.swift
//  ChangeRootDemo
//
//  Created by lunkr on 2021/6/23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var auth: Auth
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button("注销") {
                auth.token = nil
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
