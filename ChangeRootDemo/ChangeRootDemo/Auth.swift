//
//  Auth.swift
//  ChangeRootDemo
//
//  Created by lunkr on 2021/6/23.
//

import Foundation
import Combine

class Auth: ObservableObject {
    @Published var token: String?
    
    var isLogined: Bool {
        return token != nil
    }
}
