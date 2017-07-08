
import XCTest
@testable import Core

class StudentTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    func testCannotRegisterForCourseWithin5DaysOfStartDate() {
        let student = Student()
        let course = Course(code: "BIOL-1507EL", name: "Biology II", startDate: Date(timeIntervalSinceNow: 60*60*24*3))
        XCTAssertFalse(student.RegisterFor(course: course))
    }

    func testCannotRegisterForCourseAlreadyEnrolledIn() {
        let student = Student()
        student.enrolledCourses.append(Course(code: "BIOL-1507EL", name: "Biology II"))
        student.enrolledCourses.append(Course(code: "MATH-4067EL", name: "Mathematical Theory of Dynamical Systems, Chaos and Fractals"))
        XCTAssertFalse(student.RegisterFor(course: Course(code: "BIOL-1507EL", name: "")))
    }

    func testCannotRegisterForCourseAlreadyRegisteredFor() {
        let student = Student()
        student.registeredCourses.append(Course(code: "BIOL-1507EL", name: "Biology II"))
        student.registeredCourses.append(Course(code: "MATH-4067EL", name: "Mathematical Theory of Dynamical Systems, Chaos and Fractals"))
        XCTAssertFalse(student.RegisterFor(course: Course(code: "BIOL-1507EL", name: "")))
    }
}

extension StudentTests {
    static var allTests : [(String, (StudentTests) -> () throws -> Void)] {
        return [
            ("testCannotRegisterForCourseWithin5DaysOfStartDate", testCannotRegisterForCourseWithin5DaysOfStartDate),
            ("testCannotRegisterForCourseAlreadyEnrolledIn", testCannotRegisterForCourseAlreadyEnrolledIn),
            ("testCannotRegisterForCourseAlreadyRegisteredFor", testCannotRegisterForCourseAlreadyRegisteredFor)
        ]
    }
}
