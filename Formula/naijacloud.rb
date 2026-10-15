# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.5.1/naijacloud_1.5.1_darwin_arm64.tar.gz"
      sha256 "d88cd25a3c78787527129ddd30a970547a1d641528f691002e53f4c7e3de694b"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.5.1/naijacloud_1.5.1_darwin_amd64.tar.gz"
      sha256 "2b9c8a3c5454227bf3ab66cf97ddcee7f0fe0e335df9aa881b64704f0d73aef9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.5.1/naijacloud_1.5.1_linux_arm64.tar.gz"
      sha256 "c98b8ef8a096b3ab109634602a7a01a3cea309761301bbee570a620728856535"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.5.1/naijacloud_1.5.1_linux_amd64.tar.gz"
      sha256 "bffc2e58f3063209c95dc3a4173c3377550996a686548774bc1a7f104d8397d4"
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
