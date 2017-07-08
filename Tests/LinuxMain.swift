import XCTest
@testable import CoreTests
@testable import UseCaseTests

XCTMain([
     testCase(StudentTests.allTests),
     testCase(UseCaseTests.allTests)
])
