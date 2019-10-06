import XCTest

import UnsignedIntegerSynthesizedByProxyTests

var tests = [XCTestCaseEntry]()
tests += UInt256Tests.allTests()
tests += Positive256Tests.allTests()
tests += UInt32ViaProxyTests.allTests()
XCTMain(tests)
