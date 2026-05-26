class OwaPiggy < Formula
  include Language::Python::Virtualenv

  desc "Get an Outlook/Graph access token without registering an Azure AD app"
  homepage "https://github.com/damsleth/owa-piggy"
  url "https://github.com/damsleth/owa-piggy/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "20fedf0385f27b8eb43652345a898fd03e2e78388f2afacdd02c7bfdc59f9f61"
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
