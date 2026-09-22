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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.36/fimake-macos-arm64"
      sha256 "4ed70ebaf684887baefdf4488fc90c33038ff80fb36817945b9162f198a1638f"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.36/fimake-macos-x64"
      sha256 "1aa58e2c40644970ef9374a61245c68baac7944600c48f9ea3c08442e60dbf50"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.36/fimake-linux-x64"
      sha256 "6494f49be0bc73947567cbc7c8d6b28755ad16c69019f63289d668d3d134ce0d"
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
