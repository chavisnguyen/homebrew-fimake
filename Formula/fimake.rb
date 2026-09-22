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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.34/fimake-macos-arm64"
      sha256 "1600524da6c50cc0659a046304f1c88c420a806f09f5708034fc8422d5edf255"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.34/fimake-macos-x64"
      sha256 "21f79904689d6ff71e61c1f7b47212193d50ca119035da93ed258c84abb1466e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.34/fimake-linux-x64"
      sha256 "51cc3576b66edeecad23eae36852b29aff7fd2c730610d186543621a24f54415"
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
