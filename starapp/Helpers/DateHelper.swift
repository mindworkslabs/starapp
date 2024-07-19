import Foundation

extension Date {
    static var calendar: Calendar {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Start week on Monday
        return calendar
    }
    
    var startOfYear: Date {
        let components = Date.calendar.dateComponents([.year], from: self)
        return Date.calendar.date(from: components)!
    }
    
    var endOfYear: Date {
        let components = DateComponents(year: 1, day: -1)
        return Date.calendar.date(byAdding: components, to: startOfYear)!
    }
    
    var daysInYear: [Date] {
        var days: [Date] = []
        var current = startOfYear
        
        // Add leading days to align the first day of the year
        let firstDayOfWeek = Date.calendar.component(.weekday, from: startOfYear)
        let leadingDays = (firstDayOfWeek - Date.calendar.firstWeekday + 7) % 7
        for _ in 0..<leadingDays {
            current = Date.calendar.date(byAdding: .day, value: -1, to: current)!
            days.insert(current, at: 0)
        }
        
        // Reset current to the start of the year
        current = startOfYear
        while current <= endOfYear {
            days.append(current)
            current = Date.calendar.date(byAdding: .day, value: 1, to: current)!
        }
        
        // Add trailing days to complete the last week
        let trailingDays = (7 - days.count % 7) % 7
        if trailingDays < 7 {
            for _ in 0..<trailingDays {
                days.append(current)
                current = Date.calendar.date(byAdding: .day, value: 1, to: current)!
            }
        }
        
        // Adding a full week to cover the edge cases
        for _ in 0..<7 {
            current = Date.calendar.date(byAdding: .day, value: 1, to: current)!
            days.append(current)
        }
        
        return days
    }
    
    func formattedAsRelative() -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else if let daysAgo = calendar.dateComponents([.day], from: self, to: Date()).day {
            if daysAgo < 31 {
                return "\(daysAgo) days ago"
            } else if daysAgo >= 365 {
                return ">1 year ago"
            } else {
                return "\(daysAgo) days ago"
            }
        } else {
            return "N/A"
        }
    }
    
    func formattedMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: self)
    }
}
