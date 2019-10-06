import XCTest

import DelTalTests

var tests = [XCTestCaseEntry]()
tests += UInt32ViaProxyTests.allTests()
XCTMain(tests)
