class Readnow < Formula
    desc "Open a random link from your Safari reading list"
    homepage "https://github.com/kiliankoe/readnow"
    url "https://github.com/kiliankoe/readnow/archive/0.1.0.tar.gz"
    sha256 "3928f352e5ec316e3f5ebc3cf493498b2c08a6014740d5186b5466ae5e4ff2a2"
    head "https://github.com/kiliankoe/readnow.git"

    depends_on :xcode

    def install
        build_path = "#{buildpath}/.build/release/readnow"
        ohai "Building readnow"
        system("swift build --disable-sandbox -c release --static-swift-stdlib")
        bin.install build_path
    end
end
