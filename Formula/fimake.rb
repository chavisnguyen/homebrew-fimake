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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.14/fimake-macos-arm64"
      sha256 "a5c86ed96ea8abfdc73f379626aede8931e3783a6a0e26b5097f5a51691408c0"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.14/fimake-macos-x64"
      sha256 "e479756926885c3412932b12e9a6832132ae3b4fe3d06a1b326a815237282a95"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.14/fimake-linux-x64"
      sha256 "b44c382cd7e47a8a6728402fd9e4b6d7e9c17e3cd8081850563bbf097bcb5ac0"
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
