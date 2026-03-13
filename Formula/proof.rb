# Homebrew formula for proof
# Repository: automazeio/homebrew-tap
# Install: brew install automazeio/tap/proof
#
# Downloads the install script and runs it non-interactively.
# The script handles platform detection and downloads the correct binary.
# After install, we move the binary into Homebrew's bin for proper
# `brew uninstall` support.

class Proof < Formula
  desc "Capture visual evidence of test execution"
  homepage "https://github.com/automazeio/proof"
  url "https://raw.githubusercontent.com/automazeio/proof/main/install/install.sh"
  version "0.20260313.0"
  sha256 "eb6d5dbd69fbc2d1b7a3a488ff2b9ad3d1b93c50335894da23fec8044e469538"
  license "Apache-2.0"

  def install
    mv "install.sh", "install.sh" unless File.exist?("install.sh")

    system "sh", "install.sh"

    # Move binary from installer location into Homebrew's bin
    local_bin = Pathname.new(Dir.home) / ".local" / "bin"
    system_bin = Pathname.new("/usr/local/bin")

    if (local_bin / "proof").exist?
      bin.install local_bin / "proof"
    elsif (system_bin / "proof").exist?
      bin.install system_bin / "proof"
    end
  end

  test do
    assert_match "proof", shell_output("#{bin}/proof --help 2>&1")
  end
end
