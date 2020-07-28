import Cocoa
import ReadnowLib

do {
	try run()
} catch let e {
	if e.localizedDescription == "The file “Bookmarks.plist” couldn’t be opened because you don’t have permission to view it." {
		print("""
            macOS has stopped readnow from accessing your Safari reading list.
            To allow access, please manually add your terminal application (Terminal.app, iTerm.app, etc.) to System Settings > Security & Privacy > Privacy > Application Data.
            Sorry for the trouble 🙈
            """)
		NSWorkspace.shared.launchApplication("System Preferences")
	} else {
		print("Error occurred: \(e.localizedDescription)")
	}
}
