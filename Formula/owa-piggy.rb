class OwaPiggy < Formula
  include Language::Python::Virtualenv

  desc "Get an Outlook/Graph access token without registering an Azure AD app"
  homepage "https://github.com/damsleth/owa-piggy"
  url "https://github.com/damsleth/owa-piggy/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "83154ae776daccd798af79017b55f5183d8ec7948bef2a4847b4f4f9551acff6"
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
