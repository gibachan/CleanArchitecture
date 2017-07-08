import Foundation

public class Course: EntityBase {
    public var code: String = ""
    public var name: String = ""
    public var description: String = ""
    public var startDate: Date = Date()
    public var endDate: Date = Date()
}

public extension Course {
    public convenience init(code: String, name: String) {
        self.init()
        self.code = code
        self.name = name
    }

    public convenience init(code: String, name: String, startDate: Date) {
        self.init()
        self.code = code
        self.name = name
        self.startDate = startDate
    }

    public convenience init(code: String, description: String, startDate: Date, endDate: Date) {
        self.init()
        self.code = code
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}
