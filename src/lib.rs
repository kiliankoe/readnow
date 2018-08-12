extern crate plist;
extern crate rand;
extern crate webbrowser;

use std::error::Error;
use std::fs;

use plist::Plist;
use rand::Rng;

pub struct Config {
    pub plist_path: String,
}

impl Config {
    pub fn new(plist_path: String) -> Config {
        Config { plist_path }
    }
}

pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
    let file = fs::File::open(config.plist_path)?;
    let plist = Plist::read(file)?;

    let dict = match plist {
        Plist::Dictionary(dict) => Some(dict),
        _ => None,
    }.unwrap();

    let mut reading_list: Option<plist::Plist> = None;

    for item in dict["Children"].as_array().unwrap() {
        let item = item.as_dictionary().unwrap();
        if item["Title"].as_string().unwrap() == "com.apple.ReadingList" {
            reading_list = Some(item["Children"].clone());
            break;
        }
    }

    let reading_list = reading_list.unwrap();
    let reading_list = reading_list.as_array().unwrap();

    let random_page = &reading_list[rand::thread_rng().gen_range(0, reading_list.len())];
    let random_page = random_page.as_dictionary().unwrap();

    let url = random_page["URLString"].as_string().unwrap();
    webbrowser::open(url)?;

    Ok(())
}
