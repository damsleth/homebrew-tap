class DidCli < Formula
  include Language::Python::Virtualenv

  desc "Command-line interface for did (time tracking) via GraphQL"
  homepage "https://github.com/damsleth/did-cli"
  url "https://github.com/damsleth/did-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "09841c995cdb60a10ab707d7b0ed53b39951d17b96f00acd8918a38e13fba3a1"
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
