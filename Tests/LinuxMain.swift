import XCTest

import BinaryIntegerSynthesizedByProxyTests

var tests = [XCTestCaseEntry]()
tests += UInt256Tests.allTests()
tests += UInt32ViaProxyTests.allTests()
XCTMain(tests)
