//
//  SectionHeader.swift
//  MacDemo
//
//  Created by lunkr on 2021/6/22.
//

import SwiftUI

struct SectionHeader: View {
    let section: HttpSection
    var body: some View {
        HStack {
            Text(section.headerCode)
            Spacer()
                .frame(width: 20)
            Text(section.headerText)
        }
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader(section: HttpSection.sample)
    }
}
