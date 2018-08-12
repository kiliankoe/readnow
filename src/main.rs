extern crate dirs;
extern crate readnow;

use std::env;
use std::process;
use std::path;

use dirs::home_dir;

use readnow::Config;

fn main() {
    let plist_path = env::var("SAFARI_BOOKMARKS_PATH").unwrap_or_else(|_| {
        let path = path::PathBuf::from("Library/Safari/Bookmarks.plist");
        let dir = home_dir().unwrap().join(path);
        dir.to_str().unwrap().to_owned()
    });
    let config = Config::new(plist_path);

    if let Err(e) = readnow::run(config) {
        eprintln!("Encountered error: {}", e);
        process::exit(1);
    }
}
