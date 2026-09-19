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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.31/fimake-macos-arm64"
      sha256 "c2b0d7169bd8fdf7a056301c02309a2b9f563e80d5a653a07cfb69f44c440002"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.31/fimake-macos-x64"
      sha256 "1e626e795daeeb748cd5584cddb467df5e34b25c285397370e6b4ee7f3edd407"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.31/fimake-linux-x64"
      sha256 "5b17898e7641fbc62da3fbe4db96a174077883207f5760ccfaadb4279ccd09b1"
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
