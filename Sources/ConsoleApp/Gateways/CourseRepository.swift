import Core
import Foundation

class CourseRepository: ICourseRepository {
    fileprivate var store = [
        "BIO150": Course(code: "BIO150", description: "Biology 150", startDate: Date(timeIntervalSinceNow: 60*60*24*30*2), endDate: Date(timeIntervalSinceNow: 60*60*24*30*6)),
        "HIS200": Course(code: "HIS200", description: "History 200", startDate: Date(timeIntervalSinceNow: 60*60*24*30*2), endDate: Date(timeIntervalSinceNow: 60*60*24*30*6)),
        "MAT100": Course(code: "MAT100", description: "Math 100", startDate: Date(timeIntervalSinceNow: 60*60*24*30*2), endDate: Date(timeIntervalSinceNow: 60*60*24*30*6))
    ]
    
    func getBy(code: String) -> Course {
        return store[code]!
    }
    
    func getAll() -> [Course] {
        return Array(store.values)
    }
}
