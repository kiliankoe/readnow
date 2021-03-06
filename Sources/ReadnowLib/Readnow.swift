import Cocoa

struct Bookmarks: Decodable {
    let Children: [Child]

    struct Child: Decodable {
        let Title: String?
        let Children: [Item]?

        struct Item: Decodable {
            let URLString: String
        }
    }

    var readingList: Child? {
        return self.Children.first { child in
            child.Title == "com.apple.ReadingList"
        }
    }

    init(fromPath path: URL) throws {
        let data = try Data(contentsOf: path)
        self = try PropertyListDecoder().decode(Bookmarks.self, from: data)
    }
}

func randomReadingListElement() throws -> Bookmarks.Child.Item {
    guard #available(macOS 10.12, *) else {
        throw "this tool requires macOS >=10.12"
    }

    let plistPath = ProcessInfo.processInfo.environment["SAFARI_BOOKMARKS_PATH"]
        ?? "\(FileManager.default.homeDirectoryForCurrentUser)Library/Safari/Bookmarks.plist"

    guard let plistURL = URL(string: plistPath) else {
        throw "\(plistPath) is not a valid file URL"
    }

    let bookmarks = try Bookmarks(fromPath: plistURL)

    guard let readingList = bookmarks.readingList else {
        throw "no reading list found"
    }

    guard let randomElement = readingList.Children?.randomElement() else {
        throw "no elements found in reading list"
    }

    return randomElement
}

public func run() throws {
    let randomElement = try randomReadingListElement()

    guard let url = URL(string: randomElement.URLString) else {
        throw "\(randomElement.URLString) is not a valid URL"
    }

    NSWorkspace.shared.open(url)
}
