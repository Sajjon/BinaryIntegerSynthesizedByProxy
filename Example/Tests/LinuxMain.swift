import XCTest

import ExampleTests

var tests = [XCTestCaseEntry]()
tests += UInt256Tests.allTests()
tests += KelvinTests.allTests()
tests += Positive256Tests.allTests()
XCTMain(tests)
