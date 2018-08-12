extern crate readnow;

use std::env;
use std::process;

use readnow::Config;

fn main() {
    let plist_path = env::var("SAFARI_BOOKMARKS_PATH").unwrap_or_else(|_| {
        "~/Library/Safari/Bookmarks.plist".to_owned()
    });
    let config = Config::new(plist_path);

    if let Err(e) = readnow::run(config) {
        eprintln!("Encountered error: {}", e);
        process::exit(1);
    }
}
