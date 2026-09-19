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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.15/fimake-macos-arm64"
      sha256 "cce459901ef487fda7c6ce10f545dcfe64def8c6ec794c264427544662ff1d45"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.15/fimake-macos-x64"
      sha256 "8b9d15262fad40c8f70f46fcef6366794ee3eeb03686e35e50384ba5c16d1841"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.15/fimake-linux-x64"
      sha256 "47c8806962b4a802f239499e4772f6ebb264bb6cf3e785f26a5524a20c9c0a0f"
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
