//
//  DateTime.swift
//  Set
//
//  Created by Marten Biesheuvel on 08/11/2018.
//  Copyright © 2018 Marten Biesheuvel. All rights reserved.
//

import Foundation

struct DateTime {
    
    private let defaultFormat = "dd-MM-yyyy"
    
    func getCurrentDate(in format: String?) -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = format ?? defaultFormat
        return formatter.string(from: date)
    }
        
    static func formatTimeIntoString(_ time: Int) -> String {
        let hours = Int(time / 3600)
        let remaining = Float(time - (hours * 3600))
        let minutes = Int(remaining / 60)
        let seconds = Int(remaining - Float(minutes * 60))
        
        var formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        if hours > 0 {
            formattedTime = String(format: "%02d:"+formattedTime, hours)
        }
        
        return formattedTime
    }
}
