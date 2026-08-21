class Threefinger < Formula
  desc "Three-finger horizontal trackpad swipe to any keyboard shortcut"
  homepage "https://github.com/firedev/threefinger"
  url "https://github.com/firedev/threefinger/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "d712f46bb78024660790c41683f2805828108f4855017b49577fe245d04d9dfe"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-O", "-import-objc-header", "mt.h", "-o", "threefinger", "main.swift"
    bin.install "threefinger"
  end

  service do
    run [opt_bin/"threefinger"]
    keep_alive true
  end

  def caveats
    <<~EOS
      Start the daemon:
        brew services start threefinger

      Grant Accessibility to the BINARY itself (not your terminal):
        System Settings → Privacy & Security → Accessibility → + →
        #{opt_bin}/threefinger
      Without it, swipes are detected but keys silently don't post.
      After every upgrade the binary changes — remove (−) and re-add it there.

      macOS's own 3-finger gestures grab the same swipes:
        System Settings → Trackpad → More Gestures → set to four fingers or off.
    EOS
  end

  test do
    assert_predicate bin/"threefinger", :executable?
  end
end
