import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UInt32ViaProxyTests.allTests)
    ]
}
#endif
