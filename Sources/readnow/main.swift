import ReadnowLib
import Security

// TODO: Handle authorization to access ~/Library/Safari

do {
    try run()
} catch let e {
    print("Error occured: \(e)")
}
