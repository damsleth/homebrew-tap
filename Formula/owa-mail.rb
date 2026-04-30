class OwaMail < Formula
  include Language::Python::Virtualenv

  desc "Mail CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/owa-mail"
  url "https://github.com/damsleth/owa-mail/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "fbfb6dbf0a34257c760d087efd9f8bd6a6d9c61051632c45273ea59231571ccf"
  license "MIT"
  head "https://github.com/damsleth/owa-mail.git", branch: "main"

  depends_on "python@3.12"
  depends_on "damsleth/tap/owa-piggy" => :recommended

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage: owa-mail", shell_output("#{bin}/owa-mail --help")
  end
end
