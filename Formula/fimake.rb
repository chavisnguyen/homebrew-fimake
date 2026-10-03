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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.41/fimake-macos-arm64"
      sha256 "ed0097dcacc4deab64078821dec1178f09bf2d263805a70a86fbc45e9baec570"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.41/fimake-macos-x64"
      sha256 "f614a22976e2484e1438fddaa05f7d07b3b577c818b8e9269832bf4a89bf544e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.41/fimake-linux-x64"
      sha256 "d10442010816a8768d42fb11751ecea0694bfb69af79ee8810a5138c7906859f"
    end
  end

  resource "manpage" do
    url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.41/fimake.1"
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
