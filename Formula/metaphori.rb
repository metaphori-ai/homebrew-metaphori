class Metaphori < Formula
  desc "AI prompt compression CLI - Compress More. Spend Less. Think Better."
  homepage "https://metaphori.dev"
  version "0.4.9"
  license "MIT"

  # Binary releases for different platforms
  if OS.mac? && Hardware::CPU.arm?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-arm64.tar.gz"
    sha256 "13b8c653abceb656827164236bab3baaffe99e10bed42234d40ded9f5c004aa5"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-amd64.tar.gz"
    sha256 "c57caccc52e33040095824038f582f3eb629ea3bfaec6bc83f4420df0f265b89"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-amd64.tar.gz"
    sha256 "f4636c89e72df57517267a48ef7e58dc4757e837557de8f05ee3b7d630e72674"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-arm64.tar.gz"
    sha256 "c82976c0cf001ccd0101ff804a9d5473406bbf34ce6ec0b24b1b7722c0d22fc7"
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