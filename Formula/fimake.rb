class Fimake < Formula
  desc "MCP server that lets AI agents read and edit Figma documents"
  homepage "https://github.com/chavisnguyen/FiMake"
  license "Apache-2.0"

  # NOTE: `url`/`sha256` below are rewritten on every published Release by
  # the "Bump Homebrew tap" workflow in chavisnguyen/FiMake. Do not edit
  # by hand. (`version` is inferred from the tag in the URL.)
  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.37/fimake-macos-arm64"
      sha256 "5536eab1660070c4dfc5f056f91646d713d7715440410e1d58dd99df3c24cc76"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.37/fimake-macos-x64"
      sha256 "852d1a872a315df92a732d1a5d74a2a265a4661b4828846980f0c777ad0f79fb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.37/fimake-linux-x64"
      sha256 "b6b39a257691117080ba99983a0b9c26ff75438d85a67a42d08356d8ce02f9a8"
    end
  end

  def install
    asset = if OS.mac?
      Hardware::CPU.arm? ? "fimake-macos-arm64" : "fimake-macos-x64"
    else
      "fimake-linux-x64"
    end
    bin.install asset => "fimake"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fimake --version")
  end
end
