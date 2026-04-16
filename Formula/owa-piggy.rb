class OwaPiggy < Formula
  include Language::Python::Virtualenv

  desc "Get an Outlook/Graph access token without registering an Azure AD app"
  homepage "https://github.com/damsleth/owa-piggy"
  head "https://github.com/damsleth/owa-piggy.git", branch: "main"
  license "WTFPL"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "usage", shell_output("#{bin}/owa-piggy --help", 2)
  end
end
