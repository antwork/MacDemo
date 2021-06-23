//
//  CodeCell.swift
//  MacDemo
//
//  Created by lunkr on 2021/6/22.
//

import SwiftUI

struct CodeCell: View {
    let status: HttpStatus
    var body: some View {
        HStack {
            Text(status.code)
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
                .frame(width: 20)
            Text(status.title)
            Spacer()
        }
    }
}

struct CodeCell_Previews: PreviewProvider {
    static var previews: some View {
        CodeCell(status: HttpStatus(code: "200", title: "ok"))
    }
}
