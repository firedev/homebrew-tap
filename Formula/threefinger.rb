class Threefinger < Formula
  desc "Swipe with three fingers on the Mac trackpad to change tabs"
  homepage "https://github.com/firedev/threefinger"
  url "https://github.com/firedev/threefinger/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "6fa0ee798c657f3659e1bb205d6d751572114089a13f5e627c8ad7f0e94f6a04"
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
        Swipe between pages                     → Off  (optional)

      Then three fingers left/right change tabs.
      Optional: keep Mission Control / App Exposé on three fingers (↑ all windows · ↓ this app).
      Config:  ~/.config/threefinger.json
    EOS
  end

  test do
    assert_predicate bin/"threefinger", :executable?
  end
end
