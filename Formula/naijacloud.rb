# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.10.0/naijacloud_1.10.0_darwin_arm64.tar.gz"
      sha256 "ba965e9fe352596b9d4cbf6de28fc48ee6eda0292606ef4d7ec2b1660e66b031"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.10.0/naijacloud_1.10.0_darwin_amd64.tar.gz"
      sha256 "a1957907e62e8607e7cf5ca343436462eca104f83ce4bc2939d487ba01e3bb7e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.10.0/naijacloud_1.10.0_linux_arm64.tar.gz"
      sha256 "f8b1865de71f4c2ef773aa38b9701a79e0513370128864dc32dc0c1856fb6775"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.10.0/naijacloud_1.10.0_linux_amd64.tar.gz"
      sha256 "e71d1b802911a4a696aa25f3058f11cc81756dc56b7bcd9d7d9184add2906efa"
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
