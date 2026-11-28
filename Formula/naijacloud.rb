# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.11.0/naijacloud_1.11.0_darwin_arm64.tar.gz"
      sha256 "84296ee7a2f229ced1be2adf43d964292084c3591d3344454f4e585b612fb647"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.11.0/naijacloud_1.11.0_darwin_amd64.tar.gz"
      sha256 "9181d4e2429c85885313813daa575bedc7367c048ef85df4df1e2210340993d1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.11.0/naijacloud_1.11.0_linux_arm64.tar.gz"
      sha256 "3e887d35b4e7c9087bb8f6df7c5a841180121673ac261872df29528695faf5eb"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.11.0/naijacloud_1.11.0_linux_amd64.tar.gz"
      sha256 "e5d1a4c956d8eef9722d40ade6bd549056c6985636f1b7f826bcabb53c8f81a3"
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
