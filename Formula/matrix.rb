class Matrix < Formula
  desc "Matrix rain screensaver for the terminal — any key launches your command"
  homepage "https://github.com/firedev/matrix"
  url "https://github.com/firedev/matrix/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "9ff633cf5417008b2c4403d5e72c2d9d8805a30e79dfaac683437ba02dc09ad2"
  license "MIT"

  uses_from_macos "python" => :build

  def install
    bin.install "matrix"
  end

  test do
    assert_match "matrix", shell_output("head -2 #{bin}/matrix")
  end
end
