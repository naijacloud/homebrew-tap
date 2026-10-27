# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.7.0/naijacloud_1.7.0_darwin_arm64.tar.gz"
      sha256 "23b3b425a666f2ff308a8cc3cca31936a6897a3a35378c7d730d4f5aed289761"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.7.0/naijacloud_1.7.0_darwin_amd64.tar.gz"
      sha256 "cb536228c1772ad3bed0cd7666899a792381124a5a6abc6a3f41e5e106ebd849"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.7.0/naijacloud_1.7.0_linux_arm64.tar.gz"
      sha256 "6ce7460307ffda425e419bde2d56eabf334e21f847f805b73da6f414bfa7f842"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.7.0/naijacloud_1.7.0_linux_amd64.tar.gz"
      sha256 "416063569e2ae6ed5da33dc2c97b0ac4b11f15e2ae878101b12bff03d92b2c6d"
    end
  end

  def install
    bin.install "naijacloud"
    # Short alias for the same executable. The archive already ships an `njc`
    # symlink, but it is recreated here so the formula states the link it owns
    # rather than depending on what tar happened to unpack.
    bin.install_symlink bin/"naijacloud" => "njc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/naijacloud --version")
    # The alias must be a working entrypoint, not just a link that exists.
    assert_match version.to_s, shell_output("#{bin}/njc --version")
    # `whoami` exits 1 when nobody is logged in, which is the expected state in
    # a sandboxed test; asserting on the message keeps the check offline.
    assert_match "Not logged in", shell_output("#{bin}/naijacloud whoami", 1)
  end
end
