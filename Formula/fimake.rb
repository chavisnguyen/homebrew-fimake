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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.38/fimake-macos-arm64"
      sha256 "e9f33ea9dfaa15245d3aa1387c338a8cd80e0ddc682621bce09a58d300be94ef"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.38/fimake-macos-x64"
      sha256 "236c046bf5ee05e1ad022245b0219d7608c5c62ee033571da2f5f18c9c3b296c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.38/fimake-linux-x64"
      sha256 "50bfa4d66ef3e5582c4a87ef6130610f28e6c04264c3d729bed78ce7cedd601d"
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
