//
//  UserDefaultsPropertyWrapper.swift
//  SwiftUI-Mac
//
//  Created by Sarah Reichelt on 7/11/19.
//
// from https://www.avanderlee.com/swift/property-wrappers/

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            print("--wrapper getter")
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            print("wrapper setter \(newValue)")
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
