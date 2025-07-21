class Metaphori < Formula
  desc "AI prompt compression CLI - Compress More. Spend Less. Think Better."
  homepage "https://metaphori.dev"
  version "0.1.2"
  license "MIT"

  # Binary releases for different platforms
  if OS.mac? && Hardware::CPU.arm?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-arm64.tar.gz"
    sha256 "e70d3d8db1e45aa76cfa4cfde97b280c91696dfb4bb8f517f286f5c77384de28"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-amd64.tar.gz"
    sha256 "1bbb521e2c566de25881f4ad262581e24d282594d23fb15246a9c3d3c334f3f0"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-amd64.tar.gz"
    sha256 "8d7e881c35b5a8a97ba895d12d696274c38507abedb74ca4cd52268230b3dfe6"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-arm64.tar.gz"
    sha256 "52d978b6d89f2ce09fb68119aef90e8ef393e7f96c0e1d8623790f82171dc5c2"
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