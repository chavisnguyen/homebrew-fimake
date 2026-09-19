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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.11/fimake-macos-arm64"
      sha256 "188cd4f8f8f69aef776d5e0c877494388e6bb23bcc325853a4e37b488e0a1914"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.11/fimake-macos-x64"
      sha256 "50db44090211ac2d34d19ac6957903cd703be5d5378354a3b45687834c311046"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.11/fimake-linux-x64"
      sha256 "db8b8221d4f749eb9d186957ce9364ac4cbeb4a06df4872294033ba33c5b59e3"
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
