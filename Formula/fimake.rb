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
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.42/fimake-macos-arm64"
      sha256 "892eac5dffee5152e372e84a90e8c2b45a90ddcd4476201920ecb537f072c074"
    end
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.42/fimake-macos-x64"
      sha256 "e940a1a426e0e715df4917055b7163f3b8fdbd6cdcbeeefd9dd1e3da0c4d6d53"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.42/fimake-linux-x64"
      sha256 "268acce22844932de4e3d12d6cf2af43d5cbbc848108ff18dc59cbb8c3beb404"
    end
  end

  resource "manpage" do
    url "https://github.com/chavisnguyen/FiMake/releases/download/v1.0.42/fimake.1"
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
