import XCTest

import readnowTests

var tests = [XCTestCaseEntry]()
tests += readnowTests.allTests()
XCTMain(tests)