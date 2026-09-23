class Threefinger < Formula
  desc "Swipe with three fingers on the Mac trackpad to change tabs"
  homepage "https://github.com/firedev/threefinger"
  url "https://github.com/firedev/threefinger/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "fbf745af13a00966e6ebb3854b0567007246160e87bf5bb3a139bd1ac5a6a0a6"
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

      Allow Accessibility (Device Control and Data Access) + Input Monitoring for threefinger (not Terminal).
      Trackpad → More Gestures → Swipe between full-screen applications
        → Swipe Left or Right with Four Fingers

      Then three fingers left/right change tabs.
      Optional: keep Mission Control / App Exposé on three fingers.

      After upgrades: brew services restart threefinger. The daemon asks for
      Accessibility itself — approve the dialog. If an old entry for a previous
      binary is still listed, remove it (−); it no longer grants anything.
      Config: ~/.config/threefinger.json
    EOS
  end

  test do
    assert_predicate bin/"threefinger", :executable?
  end
end
