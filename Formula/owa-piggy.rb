class OwaPiggy < Formula
  include Language::Python::Virtualenv

  desc "Get an Outlook/Graph access token without registering an Azure AD app"
  homepage "https://github.com/damsleth/owa-piggy"
  url "https://github.com/damsleth/owa-piggy/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "9519041146d6494b55bd69d25d81e495d028168366905bf97f3b50dace149deb"
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
