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
      Trackpad → More Gestures → move system swipes to four fingers:
        Mission Control → Swipe Up with Four Fingers
        App Exposé → Swipe Down with Four Fingers
        Swipe between full-screen applications → Swipe Left or Right with Four Fingers

      Then three fingers left/right change tabs.

      After upgrades the old Accessibility entry is stale even if it shows on
      (Homebrew builds are ad-hoc signed): remove it (−), then + the binary.
      The daemon restarts itself once granted.
      Config: ~/.config/threefinger.json
    EOS
  end

  test do
    assert_predicate bin/"threefinger", :executable?
  end
end
