import XCTest
@testable import Core

class MockBaseAuthService: IAuthService {
    func isAuthenticated() -> Bool {
        return false
    }
}

class MockBaseStudentRepository: IStudentRepository {
    func getBy(id: Int) -> Student {
        return Student()
    }

    func save(student: Student) {}
}

class MockBaseCourseRepository: ICourseRepository {
    func getBy(code: String) -> Course {
        return Course()
    }

    func getAll() -> [Course] {
        return []
    }
}

class UseCaseTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    func testCannotRegisterForCoursesWhenNotLoggedIn() {
        let mockAuthService = MockBaseAuthService()
        let mockStudentRepository = MockBaseStudentRepository()
        let mockCourseRepository = MockBaseCourseRepository()

        let useCase = RequestCourseRegistrationInteractor(authService: mockAuthService, studentRepository: mockStudentRepository, courseRepository: mockCourseRepository)

        // act
        let response = useCase.handle(message: CourseRegistrationRequestMessage(studentId: 0, selectedCourseCodes: []))

        // assert
        XCTAssertFalse(response.success)
        XCTAssertEqual(response.message, "Operation failed, not authenticated.")
    }

    func testCannotRegisterForCourseAlreadyEnrolledIn() {
        class MockAuthService: MockBaseAuthService {
            override func isAuthenticated() -> Bool {
                return true
            }
        }

        class MockCourseRepository: MockBaseCourseRepository {
            override func getBy(code: String) -> Course {
                return Course(code: "BL0150", name: "")
            }
        }

        class MockStudentRepository: MockBaseStudentRepository {
            override func getBy(id: Int) -> Student {
                let student = Student()
                student.enrolledCourses.append(Course(code: "BL0150", name: ""))
                return student
            }
        }

        // arrange
        let mockAuthService = MockAuthService()
        let mockCourseRepository = MockCourseRepository()
        let mockStudentRepository = MockStudentRepository()

        let useCase = RequestCourseRegistrationInteractor(authService: mockAuthService, studentRepository: mockStudentRepository, courseRepository: mockCourseRepository)

        // act
        let response = useCase.handle(message: CourseRegistrationRequestMessage(studentId: 0, selectedCourseCodes: ["BL0150"]))

        // assert
        XCTAssertFalse(response.success)
        XCTAssertTrue(response.errors!.contains(where: { $0 == "unable to register for BL0150" }))
    }

    func testCannotRegisterForCourseWithin5DaysOfStartDate() {
        class MockAuthService: MockBaseAuthService {
            override func isAuthenticated() -> Bool {
                return true
            }
        }

        class MockCourseRepository: MockBaseCourseRepository {
            override func getBy(code: String) -> Course {
                return Course(code: "BL0150", name: "", startDate: Date(timeIntervalSinceNow: 60*60*24*3))
            }
        }

        class MockStudentRepository: MockBaseStudentRepository {
            override func getBy(id: Int) -> Student {
                return Student()
            }
        }

        // arrange
        let mockAuthService = MockAuthService()
        let mockCourseRepository = MockCourseRepository()
        let mockStudentRepository = MockStudentRepository()

        let useCase = RequestCourseRegistrationInteractor(authService: mockAuthService, studentRepository: mockStudentRepository, courseRepository: mockCourseRepository)

        // act
        let response = useCase.handle(message: CourseRegistrationRequestMessage(studentId: 0, selectedCourseCodes: ["BL0150"]))

        // assert
        XCTAssertFalse(response.success)
        XCTAssertTrue(response.errors!.contains(where: { $0 == "unable to register for BL0150" }))
    }
}

extension UseCaseTests {
    static var allTests : [(String, (UseCaseTests) -> () throws -> Void)] {
        return [
            ("testCannotRegisterForCoursesWhenNotLoggedIn", testCannotRegisterForCoursesWhenNotLoggedIn),
            ("testCannotRegisterForCourseAlreadyEnrolledIn", testCannotRegisterForCourseAlreadyEnrolledIn),
            ("testCannotRegisterForCourseWithin5DaysOfStartDate", testCannotRegisterForCourseWithin5DaysOfStartDate)
        ]
    }
}
