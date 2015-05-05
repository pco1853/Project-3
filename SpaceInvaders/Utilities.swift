//
//  Utilities.swift
//  SpaceInvaders
//
//  Created by Student on 4/22/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation

extension Array {
    func randomElement() -> T {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}