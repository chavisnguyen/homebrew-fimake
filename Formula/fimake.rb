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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.32/fimake-macos-arm64"
      sha256 "6d47b3062badf959847e0002d7039f36cf2fe483d48d6337ce1e220dc058a2cb"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.32/fimake-macos-x64"
      sha256 "ef0e466d06159987e7e5d8ceffc44730bd91202d49f5c59e426f9d31079adc68"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.32/fimake-linux-x64"
      sha256 "02ef1636ac776425070b76765ce91cb1b4fefc91a6cd6ade5979ae1e93b2b6de"
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
