class Matrix < Formula
  desc "Matrix rain screensaver for the terminal — any key launches your command"
  homepage "https://github.com/firedev/matrix"
  url "https://github.com/firedev/matrix/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "a5ce476c41dda1036cc4f5e3d0974696201bc4253e5afbca057844ee1e43cfed"
  license "MIT"

  uses_from_macos "python" => :build

  def install
    bin.install "matrix"
  end

  test do
    assert_match "matrix", shell_output("head -2 #{bin}/matrix")
  end
end
