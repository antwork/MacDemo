//
//  ContentView.swift
//  MacDemo
//
//  Created by lunkr on 2021/6/22.
//

import SwiftUI

struct ContentView: View {
    let sections = Bundle.main.decode([HttpSection].self, from: "httpcodes.json")
    
    var body: some View {
        NavigationView {
             List {
                ForEach(sections) { section in
                    Section(header: SectionHeader(section: section)) {
                        ForEach(section.statuses) { status in
                            NavigationLink(destination: DetailView(status: status)) {
                                CodeCell(status: status)
                            }
                        }
                    }
                }
             }
             .frame(minWidth: 200)
             .listStyle(SidebarListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
