//
//  Int+Times.swift
//  LittleBookOfSemaphores
//
//  Created by Aliaksandr Bialiauski on 2/25/19.
//  Copyright © 2019 Alexander Belyavskiy. All rights reserved.
//

import Foundation

extension Int {
    func times(_ block: () -> Void) {
        for _ in 0..<self {
            block()
        }
    }
}
