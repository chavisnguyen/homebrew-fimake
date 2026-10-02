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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.40/fimake-macos-arm64"
      sha256 "3e206dc47937744aabaaa07cfa4c98b9c8a423f13e90b99183d0b74e428e84e0"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.40/fimake-macos-x64"
      sha256 "fd7f1194b12fe0b97fe6fb6934f0163fe79b90e47a7617de320cfadfd6b799b3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.40/fimake-linux-x64"
      sha256 "bc33b6766287d6095b7f9c98805a7bc1bcbdf194d14356a9b39b59bac677d050"
    end
  end

  resource "manpage" do
    url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.40/fimake.1"
    sha256 "ba643eca3e9ccfa693478c6c1e78a0c34de3dc8b085cb43b003afcc824057804"
  end

  def install
    asset = if OS.mac?
      Hardware::CPU.arm? ? "fimake-macos-arm64" : "fimake-macos-x64"
    else
      "fimake-linux-x64"
    end
    bin.install asset => "fimake"
    resource("manpage").stage { man1.install "fimake.1" }
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
    assert_predicate man1/"fimake.1", :exist?
  end
end
