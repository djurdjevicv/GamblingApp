//
//  WinningNumbers.swift
//  GamblingApp
//
//  Created by Vladimir Djurdjevic on 5/18/24.
//

import Foundation

struct WinningNumbers: Codable, Hashable {
    let list : [Int]?

    init(list: [Int]?) {
        self.list = list
    }
}
