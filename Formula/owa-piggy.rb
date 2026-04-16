class OwaPiggy < Formula
  include Language::Python::Virtualenv

  desc "Get an Outlook/Graph access token without registering an Azure AD app"
  homepage "https://github.com/damsleth/owa-piggy"
  url "https://github.com/damsleth/owa-piggy/archive/refs/heads/main.tar.gz"
  sha256 "c86ba5f59cdcc9ed4a8a7855da50fad2a3c405faf10b80b076433a0a6ec6fe17"
  version "0.1.0"
  license "WTFPL"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "usage", shell_output("#{bin}/owa-piggy --help", 2)
  end
end
