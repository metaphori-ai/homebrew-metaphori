class Metaphori < Formula
  desc "AI prompt compression CLI - Compress More. Spend Less. Think Better."
  homepage "https://metaphori.dev"
  version "0.4.10"
  license "MIT"

  # Binary releases for different platforms
  if OS.mac? && Hardware::CPU.arm?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-arm64.tar.gz"
    sha256 "89513afe00a5fafbd419b92663a1042a81d0bfc6d5c28fa7f62acbef1e560582"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-darwin-amd64.tar.gz"
    sha256 "ec4b8be17e888df2f2eb760bbb9ec143f986050f8345fddd1edfc0679034a03a"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-amd64.tar.gz"
    sha256 "199c4d79a4769d88ac49f5d69aedc7229a5647fa416f40a64b27652ee00e5eb0"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://metaphori-releases.s3.amazonaws.com/v#{version}/metaphori-#{version}-linux-arm64.tar.gz"
    sha256 "d48b460f2291509c6cd02e5718675ce3b35750a771a827b309633787e04b04a6"
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