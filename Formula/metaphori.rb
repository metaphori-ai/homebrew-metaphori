class Metaphori < Formula
  desc "AI prompt compression CLI - Compress More. Spend Less. Think Better."
  homepage "https://metaphori.dev"
  version "0.4.1"
  license "MIT"

  # Binary releases for different platforms
  if OS.mac? && Hardware::CPU.arm?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-arm64.tar.gz"
    sha256 "27f728c8e04087f7d012891c3c37e8c55f0dc95ec1f9605edcc1a60ce34e5106"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-amd64.tar.gz"
    sha256 "bf37bcfbdc0c1cf9e39ca63272c8c04a3d7e08980988ea10db7c0a1eb14e2d1e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-amd64.tar.gz"
    sha256 "453abfdb5101580f4462f83a086107e4d7992fa5451f686038564272e4af7538"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-arm64.tar.gz"
    sha256 "d3c5c49454a5c814f64d435bb444a398fb1a26b2c6ed972e2092a88e1c25af8c"
  end

  def install
    bin.install "metaphori"
    
    # Install shell completions
    generate_completions_from_executable(bin/"metaphori", "completion")
  end

  test do
    # Test version output
    assert_match "metaphori version #{version}", shell_output("#{bin}/metaphori --version")
    
    # Test help output
    assert_match "Compress More. Spend Less. Think Better.", shell_output("#{bin}/metaphori --help")
    
    # Test that TUI doesn't launch in test mode
    assert_match "Metaphori Engine", shell_output("#{bin}/metaphori --help")
  end
end