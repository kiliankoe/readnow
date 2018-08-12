import XCTest

import readnowTests
import ReadnowLibTests

var tests = [XCTestCaseEntry]()
tests += readnowTests.allTests()
tests += ReadnowLibTests.allTests()
XCTMain(tests)
