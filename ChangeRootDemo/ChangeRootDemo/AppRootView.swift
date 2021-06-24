//
//  RootView.swift
//  ChangeRootDemo
//
//  Created by lunkr on 2021/6/23.
//

import SwiftUI

struct AppRootView: View {
    
    @ObservedObject var auth:Auth
    
    var body: some View {
        Group {
            if auth.isLogined {
                MainView()
            } else {
                LoginView()
            }
        }.environmentObject(auth)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView(auth: Auth())
    }
}
