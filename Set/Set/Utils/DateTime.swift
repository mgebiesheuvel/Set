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
}
