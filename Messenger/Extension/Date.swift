//
//  Date.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 11.11.2024.
//

import SwiftUI

extension Date {
    private var timeFormater: DateFormatter {
        let formater = DateFormatter()
        formater.timeStyle = .short
        formater.dateFormat = "HH.mm"
        return formater
    }
    private var dateFormater: DateFormatter {
        let formater = DateFormatter()
        formater.timeStyle = .medium
        formater.dateFormat = "MM.dd.yy"
        return formater
    }
    
    private func timeString() -> String {
        timeFormater.string(from: self)
    }
    
    private func dateString() -> String {
        dateFormater.string(from: self)
    }
    
    func timeTampString() -> String {
        if Calendar.current.isDateInToday(self) {
            return timeString()
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return dateString()
        }
    }
}
