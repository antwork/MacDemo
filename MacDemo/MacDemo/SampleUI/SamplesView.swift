//
//  SamplesView.swift
//  SwiftUI-Mac
//
//  Created by Sarah Reichelt on 7/11/19.
//  Copyright © 2019 Sarah Reichelt. All rights reserved.
//

import SwiftUI

struct SamplesView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        Text("Hello World")
        .frame(width: 300, height: 200)
        .padding()
    }
}

struct SamplesView_Previews: PreviewProvider {
    static var previews: some View {
        SamplesView()
    }
}

struct ExplanatoryText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(.secondary)
    }
}
