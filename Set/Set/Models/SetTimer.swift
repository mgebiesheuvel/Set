//
//  SetTimer.swift
//  Set
//
//  Created by Marten Biesheuvel on 10/12/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct SetTimer {
    private(set) var runningTime = 0
    private(set) var setStartTime = 0
    
    mutating func updateRunningTime() {
        runningTime += 1
    }
    
    mutating func restore(time: Int) {
        runningTime = time
    }
    
    mutating func getTimeNeeded() -> Int {
        let timeNeeded = runningTime - setStartTime
        setStartTime = runningTime
        return timeNeeded < 1 ? 1 : timeNeeded // always return 1 or more to prevent a division by zero error
    }
}
