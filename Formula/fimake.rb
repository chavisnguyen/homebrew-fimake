class Fimake < Formula
  desc "MCP server that lets AI agents read and edit Figma documents"
  homepage "https://github.com/chavisnguyen/FiMake"
  version "1.0.0"
  license "Apache-2.0"

  # NOTE: sha256 values below are placeholders. They are rewritten with real
  # checksums by the "Bump Homebrew tap" workflow in chavisnguyen/FiMake on
  # every published Release. Do not edit by hand.
  on_macos do
    on_arm do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.0/fimake-macos-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
      def install
        bin.install "fimake-macos-arm64" => "fimake"
      end
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.0/fimake-macos-x64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
      def install
        bin.install "fimake-macos-x64" => "fimake"
      end
    end
  end

  on_linux do
    url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.0/fimake-linux-x64"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    def install
      bin.install "fimake-linux-x64" => "fimake"
    end
  end

  livecheck do
    url :homepage
    strategy :github_latest
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fimake --version")
  end
end
