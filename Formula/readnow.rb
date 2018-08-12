class Wikitranslate < Formula
    desc "Open a random link from your Safari reading list"
    homepage "https://github.com/kiliankoe/readnow"
    url "https://github.com/kiliankoe/readnow/archive/0.1.0.tar.gz"
    sha256 "5490e9ca561af0f03e3727b8022d2e2947927989d6ac7c0cbee2b3cf59022cd2"
    head "https://github.com/kiliankoe/readnow.git"

    depends_on :xcode

    def install
        build_path = "#{buildpath}/.build/release/readnow"
        ohai "Building readnow"
        system("swift build --disable-sandbox -c release --static-swift-stdlib")
        bin.install build_path
    end
end
