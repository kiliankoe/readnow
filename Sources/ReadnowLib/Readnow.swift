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

public func run() throws {
    guard #available(macOS 10.12, *) else {
        throw "this tool requires macOS >=10.12"
    }

    let plistPath = URL(string: "\(FileManager.default.homeDirectoryForCurrentUser)/Library/Safari/Bookmarks.plist")!
    let bookmarks = try Bookmarks(fromPath: plistPath)

    guard let readingList = bookmarks.readingList else {
        throw "no reading list found"
    }

    guard let randomElement = readingList.Children?.randomElement() else {
        throw "no elements found in reading list"
    }

    guard let url = URL(string: randomElement.URLString) else {
        throw "\(randomElement.URLString) is not a valid URL"
    }

    NSWorkspace.shared.open(url)
}
