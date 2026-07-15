# Homebrew formula for envapor
# Repository: automazeio/homebrew-tap
# Install: brew install automazeio/tap/envapor
#
# This is a thin shim over the curl-based installer shipped in the envapor
# repo. Instead of downloading a binary directly, it fetches install.sh and
# runs it non-interactively, pinned to this formula's version. The installer is
# pointed at Homebrew's keg (ENVAPOR_INSTALL_DIR=#{bin}) so the binary lands in
# Homebrew's prefix/opt tree rather than /usr/local/bin or ~/.local/bin. That
# keeps upgrades and `brew uninstall` fully managed by Homebrew while reusing a
# single installer across macOS and Linux.
#
# On each release, bump `version` to the published tag and refresh `sha256` to
# match installers/install.sh at that ref.

class Envapor < Formula
  desc "Commit your secrets, securely"
  homepage "https://github.com/automazeio/envapor"
  url "https://raw.githubusercontent.com/automazeio/envapor/main/installers/install.sh"
  version "0.0.0"
  sha256 "684f2e5692b22510ca959141506db7eef4c32b2864da3926aa5e84705939a68d"
  license "Apache-2.0"

  def install
    # Pin the download to this formula's version and direct the installer to
    # write into the keg's bin instead of a system-wide path.
    ENV["ENVAPOR_VERSION"] = "v#{version}"
    ENV["ENVAPOR_INSTALL_DIR"] = bin.to_s

    system "sh", "install.sh"
  end

  test do
    assert_match "envapor", shell_output("#{bin}/envapor --version 2>&1")
  end
end
