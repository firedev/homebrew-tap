class Threefinger < Formula
  desc "Swipe with three fingers on the Mac trackpad to change tabs"
  homepage "https://github.com/firedev/threefinger"
  url "https://github.com/firedev/threefinger/archive/refs/tags/v1.1.5.tar.gz"
  sha256 "2f8ed77a78718183b9ad748af5dcb139665c7bfa3fe6bf3ff71e38bfdef111cd"
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
      brew services start threefinger
      #{opt_bin}/threefinger --check --open

      Allow Accessibility + Input Monitoring for threefinger (not Terminal).
      Trackpad → More Gestures → Swipe between full-screen applications
        → Swipe Left or Right with Four Fingers

      Then three fingers left/right change tabs.
      Optional: keep Mission Control / App Exposé on three fingers.

      After upgrades: remove (−) and re-add Accessibility for the new binary,
      then brew services restart threefinger. A grant does not apply to a
      daemon that is already running.
      Config: ~/.config/threefinger.json
    EOS
  end

  test do
    assert_predicate bin/"threefinger", :executable?
  end
end
