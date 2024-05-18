//
//  GreeceKinoContent.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import Foundation

struct GreeceKinoContent : Codable {
    let content : [GreeceKinoDTO]?
    
    init(content: [GreeceKinoDTO]?) {
        self.content = content
    }
}
