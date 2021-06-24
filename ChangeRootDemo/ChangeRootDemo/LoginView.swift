//
//  LoginView.swift
//  ChangeRootDemo
//
//  Created by lunkr on 2021/6/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var auth:Auth
    
    var body: some View {
        Button("登录") {
            auth.token = "123"
        }
        .frame(width: 300, height: 200)
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView().environmentObject(Auth())
    }
}
