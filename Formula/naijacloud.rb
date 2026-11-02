# Rendered by scripts/render-packaging.mjs and committed to the tap repository
# (Pherwerz/homebrew-tap), which is what makes `brew install naijacloud` work.
#
# Binary-only formula: the bottle IS the release archive, so Homebrew downloads
# and unpacks rather than compiling anything.
class Naijacloud < Formula
  desc "Deploy and manage NaijaCloud hosting from the terminal, and over MCP"
  homepage "https://naijacloud.com"
  version "1.8.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.8.1/naijacloud_1.8.1_darwin_arm64.tar.gz"
      sha256 "2a42841906b126eb5ad1ac8387a36d3980ec684652c1d318c296b216e6e68542"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.8.1/naijacloud_1.8.1_darwin_amd64.tar.gz"
      sha256 "a162dc7e045c063e095ba0ab2303fb015bbfffafca292cc5b2d2a5e6f76064cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.8.1/naijacloud_1.8.1_linux_arm64.tar.gz"
      sha256 "0d9b61bbdb59fcf4e7aeee236017e563463223278470c68ad895637d4ea09eda"
    end

    on_intel do
      url "https://github.com/naijacloud/nc-cli/releases/download/v1.8.1/naijacloud_1.8.1_linux_amd64.tar.gz"
      sha256 "19a823d16e3958d732704bbfde57d7bcb0603b2848f463feb9087ce0e74e7894"
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
