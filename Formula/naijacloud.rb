# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.8.0/naijacloud_1.8.0_darwin_arm64.tar.gz"
      sha256 "74618e8d8bac4a1eaad148f718836cb9eb98be7e5c0b4ac46eae79f54170673a"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.8.0/naijacloud_1.8.0_darwin_amd64.tar.gz"
      sha256 "f9be572195bde6ba60ae8e4c7e2a14e6eb79dbbbc2db3ebca7684b63a67a42c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.8.0/naijacloud_1.8.0_linux_arm64.tar.gz"
      sha256 "90d1616be65bd8443d5b65be1890b3f7b37c5f921e33da82c7a2c13aeab71e25"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.8.0/naijacloud_1.8.0_linux_amd64.tar.gz"
      sha256 "7fc5b25f9d8ae516ed4ac881bcef6b61349c3b6ac01c186050644071bfb11a1f"
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
