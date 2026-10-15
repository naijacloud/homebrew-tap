# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.5.0/naijacloud_1.5.0_darwin_arm64.tar.gz"
      sha256 "80598e507b41c3bcc6161b664337c53fb2ae02eb71f3555eb8d0019206bb2944"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.5.0/naijacloud_1.5.0_darwin_amd64.tar.gz"
      sha256 "e999b7bb4418ed9e40e301373ff2473b9684ae1694a9332a46b91248d79f4057"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.5.0/naijacloud_1.5.0_linux_arm64.tar.gz"
      sha256 "2c4e39e62653665f36ca4b83374bc1f056fbbf7326c0f7115a068055526f350a"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.5.0/naijacloud_1.5.0_linux_amd64.tar.gz"
      sha256 "428ee4401af05d7f9aebaca88383d59941425a812a81bbed6301bbc8aa56ceda"
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
