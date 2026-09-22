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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.35/fimake-macos-arm64"
      sha256 "ef10976283ba8619c7d36b2ba19f54abb7f936427ca3c3225f6e22fcf8dcf54f"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.35/fimake-macos-x64"
      sha256 "3a7c5d26c26496fbdab29f104fa0abf673c1e452355636f4afda8f9d2d766b39"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.35/fimake-linux-x64"
      sha256 "829b0794454ee6ae0f40d4d290911f9d2c77fd2064311738aab93eb385a2337d"
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
