import XCTest
import class Foundation.Bundle
@testable import ReadnowLib

final class ReadnowLibTests: XCTestCase {
    func testBookmarks() throws {
        let fixtures = productsDirectory.appendingPathComponent("Bookmarks.plist")
        let bookmarks = try Bookmarks(fromPath: fixtures)

        XCTAssertEqual(bookmarks.Children.count, 1)
        XCTAssertEqual(bookmarks.readingList?.Children?.count, 1)
    }

    func testRandomElement() throws {
        let fixtures = productsDirectory.appendingPathComponent("Bookmarks.plist")
        set(environmentVariable: "SAFARI_BOOKMARKS_PATH", withValue: fixtures.absoluteString)

        let randomElement = try randomReadingListElement()
        XCTAssertEqual(randomElement.URLString, "https://swift.org")
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    private func set(environmentVariable name: String, withValue value: String) {
        setenv(name, value, 1)
    }

    static var allTests = [
        ("testBookmarks", testBookmarks),
        ("testRandomElement", testRandomElement),
    ]
}
