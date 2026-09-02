class Threefinger < Formula
  desc "Three-finger swipe on the Mac trackpad → switch tabs. Or the shortcut of your choice."
  homepage "https://github.com/firedev/threefinger"
  url "https://github.com/firedev/threefinger/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "1bab60168fabaaa414d9d09460757910224bbfb49884dea5cd40418712a1937d"
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
        Swipe between full-screen applications  → Swipe Left or Right with Four Fingers
        Keep Mission Control / App Exposé on three fingers
        Swipe between pages                     → Off  (optional)

      Three fingers: ↑ all windows · ↓ this app · ←/→ tabs

      Default: 3-finger swipe ←/→ switches tabs (Ctrl-Shift-Tab / Ctrl-Tab)
      Config:  ~/.config/threefinger.json
    EOS
  end

  test do
    assert_predicate bin/"threefinger", :executable?
  end
end
