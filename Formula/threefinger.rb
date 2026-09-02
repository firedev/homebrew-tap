class Threefinger < Formula
  desc "Swipe with three fingers on the Mac trackpad to change tabs"
  homepage "https://github.com/firedev/threefinger"
  url "https://github.com/firedev/threefinger/archive/refs/tags/v1.1.4.tar.gz"
  sha256 "0857008a1e98004fa1d00cb249be2b97c9f7aa64086cb62d49967b4a13559808"
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

      After upgrades: remove (−) and re-add Accessibility for the new binary.
      Config: ~/.config/threefinger.json
    EOS
  end

  test do
    assert_predicate bin/"threefinger", :executable?
  end
end
