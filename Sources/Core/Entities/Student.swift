import Foundation

public class Student: EntityBase {
    public var firstName: String = ""
    public var lastName: String = ""
    public var registeredCourses: [Course] = []
    public var enrolledCourses: [Course] = []
}

public extension Student {
    public func RegisterFor(course: Course) -> Bool {
        // student has not previously enrolled
        if enrolledCourses.contains(where: { $0.code == course.code }) {
            return false
        }

        // student has not previously registered
        if registeredCourses.contains(where: { $0.code == course.code }) {
            return false
        }
        
        // registratraion cannot occur with 5 days of course start date
        if intervalDays(date: course.startDate) < 5 {
            return false
        }
        
        return true
    }
    
    fileprivate func intervalDays(date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: Date()) else { return 0 }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: date) else { return 0 }
        return end - start
    }
}
