//
//  HttpStatus.swift
//  SwiftUI-Mac
//
//  Created by Sarah Reichelt on 6/11/19.
//  Copyright © 2019 Sarah Reichelt. All rights reserved.
//

import Foundation

struct HttpStatus: Identifiable, Codable {
    let id = UUID()
    let code: String
    let title: String
    
    var imageUrl: URL {
        let address = "https://http.cat/\(code).jpg"
        return URL(string: address)!
    }
    
    private enum CodingKeys: String, CodingKey {
        case code, title
    }
}

struct HttpSection: Identifiable, Codable {
    let id = UUID()
    let headerCode: String
    let headerText: String
    let statuses: [HttpStatus]
    
    private enum CodingKeys: String, CodingKey {
        case headerCode, headerText, statuses
    }
}

extension HttpStatus {
    static var sample: HttpStatus {
        HttpStatus(code: "200", title: "OK")
    }
}

extension HttpSection {
    static var sample: HttpSection {
        HttpSection(headerCode: "2xx", headerText: "Success", statuses: [])
    }
}
