# 📖 readnow

Keep throwing links into your Safari's reading list without ever looking at them again? Want to stop thinking of your reading list as the place where articles go to die?

This simple tool opens a random link from your reading list for you to read. Now.

![demo](https://user-images.githubusercontent.com/2625584/44006031-45d2da7a-9e7d-11e8-80f8-2b3accc9f79b.gif)

Keep this up with somewhat of a routine and you'll (hopefully) be able to bring the count of pages in your reading list back down 🖖



## Installation

```shell
$ brew tap kiliankoe/readnow https://github.com/kiliankoe/readnow.git
$ brew install readnow
```



## Caveat

Unfortunately macOS 10.14 Mojave blocks random applications from accessing `~/Library/Safari`, which is a good thing. Being a simple binary, it appears readnow can't request access by itself, but relies on you proactively giving access to user data to your terminal application (Terminal.app, iTerm.app, etc.). Do so by going to System Settings > Security & Privacy > Privacy > Application Data and adding your terminal, thanks!

readnow will also you prompt you for this if it can't access Safari's Bookmarks.plist when launched.
