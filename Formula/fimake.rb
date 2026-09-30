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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.39/fimake-macos-arm64"
      sha256 "9ad79019950d89b35c22bd2251e2daab5efe42f5309eab9691d0ad821a7e5887"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.39/fimake-macos-x64"
      sha256 "a83533e8861efc7ba4d6595f7c0399120b948b5752a5f59b52a5291221daec05"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.39/fimake-linux-x64"
      sha256 "5d04594f2450feab70a0528316c0a4143e926b831e96daa2b1a5ab4fe6e0d8fc"
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

  service do
    run [opt_bin/"fimake"]
    environment_variables TRANSPORT: "streamable-http"
    keep_alive true
    log_path var/"log/fimake.log"
    error_log_path var/"log/fimake.log"
  end

  def caveats
    <<~EOS
      Next steps (one-time):
        fimake install-plugin        # register the Figma plugin (macOS)
        brew services start fimake   # run the shared server in the background
      Then add http://localhost:10101/mcp to your MCP client.
      Run `fimake doctor` if anything looks off.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fimake --version")
  end
end
