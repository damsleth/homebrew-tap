class OwaPiggy < Formula
  include Language::Python::Virtualenv

  desc "Get an Outlook/Graph access token without registering an Azure AD app"
  homepage "https://github.com/damsleth/owa-piggy"
  url "https://github.com/damsleth/owa-piggy/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "d5a3c45dcdfdd04d07082a2d37ecc85a8cd3d69930e4cdad394f593fdd556093"
  license "MIT"
  head "https://github.com/damsleth/owa-piggy.git", branch: "main"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "usage", shell_output("#{bin}/owa-piggy --help")
  end
end
