# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.4.0/naijacloud_1.4.0_darwin_arm64.tar.gz"
      sha256 "0ecb6593054a484e6bc7f2e0bed103cdd871d1034384aa1a7dd11000296b3fb6"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.4.0/naijacloud_1.4.0_darwin_amd64.tar.gz"
      sha256 "2273b3676d74cd20b9236bba7c7ed1325e26372d157537d371903923200aec40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.4.0/naijacloud_1.4.0_linux_arm64.tar.gz"
      sha256 "72649966b73546db2f764bec2ff028a8d6416971cfb82c38b1ac49e9186d47f0"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.4.0/naijacloud_1.4.0_linux_amd64.tar.gz"
      sha256 "df5e2758dbd938d2826b11027d2dfd724ccf8d3865bb0a7a42a84dfee3418af0"
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
