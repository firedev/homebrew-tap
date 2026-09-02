class Threefinger < Formula
  desc "Three-finger horizontal trackpad swipe to any keyboard shortcut"
  homepage "https://github.com/firedev/threefinger"
  url "https://github.com/firedev/threefinger/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "d9195e0a58f6403d09e952a423487f1f4d4bd6dadf15424a22f7f2eda0c6db0f"
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
      Start the daemon, then check permissions (opens Settings if anything is missing):
        brew services start threefinger
        #{opt_bin}/threefinger --check --open

      If Accessibility / Input Monitoring is MISSING — add:
        #{opt_bin}/threefinger
      (after every upgrade: remove (−) first, then re-add; toggling is not enough)

      --check --open lands on Trackpad → More Gestures (needs Accessibility). Then:
        Swipe between pages                     → Off
        Swipe between full-screen applications  → Swipe Left or Right with Four Fingers

      Default: 3-finger swipe ←/→ switches tabs (⌃⇧Tab / ⌃Tab)
      Config:  ~/.config/threefinger.json
    EOS
  end

  test do
    assert_predicate bin/"threefinger", :executable?
  end
end
