# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.9.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.9.1/naijacloud_1.9.1_darwin_arm64.tar.gz"
      sha256 "ce5e2bbf05c723de11f27b4524c94170d38ab379971b64baa678a8d9a6a82522"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.9.1/naijacloud_1.9.1_darwin_amd64.tar.gz"
      sha256 "8cd09340fe4399474172f25f7e6611b18bf8dee52403d0668ee5d83c70d58081"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.9.1/naijacloud_1.9.1_linux_arm64.tar.gz"
      sha256 "2bee6ea412ee004e122857631c6c05f4d7995c3947367685e0097c72c83950f8"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.9.1/naijacloud_1.9.1_linux_amd64.tar.gz"
      sha256 "2cc5f2e5a729d821d1295bb4eb39e330ccd44ec2c1c7bd3183f9fab6e52d047f"
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
