class Metaphori < Formula
  desc "AI prompt compression CLI - Compress More. Spend Less. Think Better."
  homepage "https://metaphori.dev"
  version "0.1.9"
  license "MIT"

  # Binary releases for different platforms
  if OS.mac? && Hardware::CPU.arm?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-arm64.tar.gz"
    sha256 "ce8bbfc0b1ac3c0246f203db584d1d8031081d10fc07aa5bbbec31f117b83b48"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-amd64.tar.gz"
    sha256 "f03f0ba5fd818d629057ee18d2dce2d6c829dce642b4528475f09495d81730a5"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-amd64.tar.gz"
    sha256 "034a4c4312d22f7a75aff7bdc561514341b1b36ee47b69bb0d6be569be965ad7"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-arm64.tar.gz"
    sha256 "9b2d1fbf5d1420693ead5f22fd9b90ccd453a44688b10e9a664ba54c3c0697e5"
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