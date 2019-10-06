import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UInt256Tests.allTests),
        testCase(Positive256Tests.allTests),
        testCase(UInt32ViaProxyTests.allTests)
    ]
}
#endif
