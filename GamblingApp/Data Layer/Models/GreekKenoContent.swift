//
//  GreekKenoContent.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import Foundation

struct GreekKenoContent : Codable {
    let content : [GreekKenoDTO]?
    
    init(content: [GreekKenoDTO]?) {
        self.content = content
    }
}
