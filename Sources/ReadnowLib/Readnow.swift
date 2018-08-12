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

    init() throws {
        guard #available(macOS 10.12, *) else {
            throw "this tool requires macOS >=10.12"
        }

        let data = try Data(contentsOf: URL(string: "\(FileManager.default.homeDirectoryForCurrentUser)/Library/Safari/Bookmarks.plist")!)
        self = try PropertyListDecoder().decode(Bookmarks.self, from: data)
    }
}

public func run() throws {
    let bookmarks = try Bookmarks()
    guard let readingList = bookmarks.readingList else {
        throw "no reading list found"
    }

    guard let randomElement = readingList.Children?.randomElement() else {
        throw "no elements found in reading list"
    }

    NSWorkspace.shared.open(URL(string: randomElement.URLString)!)
}
