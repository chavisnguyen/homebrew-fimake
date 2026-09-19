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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.16/fimake-macos-arm64"
      sha256 "98b84dead9705c006adedc4381a0335ee051b792e924ce6176cca31fca752feb"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.16/fimake-macos-x64"
      sha256 "c74ef265be0e214c984fcefaa887d0933040867c68bf7075da05c9ff4b283b37"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.16/fimake-linux-x64"
      sha256 "b5a61356f76778e1601e55c69d455099b9f104de21a6fdb355df60ec66973f29"
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
