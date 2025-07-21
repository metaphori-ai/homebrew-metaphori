class Metaphori < Formula
  desc "AI prompt compression CLI - Compress More. Spend Less. Think Better."
  homepage "https://metaphori.dev"
  version "0.1.0"
  license "MIT"

  # Binary releases for different platforms
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/metaphori-com/metaphori-cli/releases/download/v#{version}/metaphori-#{version}-darwin-arm64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"  # TO BE UPDATED
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/metaphori-com/metaphori-cli/releases/download/v#{version}/metaphori-#{version}-darwin-amd64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"  # TO BE UPDATED
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/metaphori-com/metaphori-cli/releases/download/v#{version}/metaphori-#{version}-linux-amd64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"  # TO BE UPDATED
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/metaphori-com/metaphori-cli/releases/download/v#{version}/metaphori-#{version}-linux-arm64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"  # TO BE UPDATED
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