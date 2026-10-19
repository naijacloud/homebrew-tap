# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.6.0/naijacloud_1.6.0_darwin_arm64.tar.gz"
      sha256 "16e4f8ebffbb4cd42fb506bb40101c69db69df657b4e0d1902e99c0b33512120"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.6.0/naijacloud_1.6.0_darwin_amd64.tar.gz"
      sha256 "bd1c2b72b0ba8cbd52749608a0ab294a12eb711cec9adc98b86670913bf5118b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.6.0/naijacloud_1.6.0_linux_arm64.tar.gz"
      sha256 "c4c8c1035117cf8f32d2a6d62e763de2bbd5f7ddb05d94462e5a299290002a37"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.6.0/naijacloud_1.6.0_linux_amd64.tar.gz"
      sha256 "fc30bdf46a183e73fff62ba372d9ddf1c977e3c2bcf11e99204496f29abb5d30"
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
