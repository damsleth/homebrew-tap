class OwaMail < Formula
  include Language::Python::Virtualenv

  desc "Mail CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/owa-mail"
  url "https://github.com/damsleth/owa-mail/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "0d1d60f70e2c3eb76b5095f1b392d8cada13272fc81733c41903bc1db7e91b39"
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
