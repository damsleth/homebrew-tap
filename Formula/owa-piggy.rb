class OwaPiggy < Formula
  include Language::Python::Virtualenv

  desc "Get an Outlook/Graph access token without registering an Azure AD app"
  homepage "https://github.com/damsleth/owa-piggy"
  url "https://github.com/damsleth/owa-piggy/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "5b211ca8868e34be6f1593e857ebe735f54ec5133d0622c02bc76cda93404cc6"
  license "WTFPL"
  head "https://github.com/damsleth/owa-piggy.git", branch: "main"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "usage", shell_output("#{bin}/owa-piggy --help")
  end
end
