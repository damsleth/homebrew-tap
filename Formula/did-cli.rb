class DidCli < Formula
  include Language::Python::Virtualenv

  desc "Command-line interface for did (time tracking) via GraphQL"
  homepage "https://github.com/damsleth/did-cli"
  url "https://github.com/damsleth/did-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "db1a3ddb47fdbe6efff5a9a27d61ee79929755b7fbe7a504ab9e95022c418bab"
  license "WTFPL"
  head "https://github.com/damsleth/did-cli.git", branch: "main"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "usage", shell_output("#{bin}/did-cli help")
  end
end
