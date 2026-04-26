class OwaCal < Formula
  include Language::Python::Virtualenv

  desc "Calendar CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/owa-cal"
  url "https://github.com/damsleth/owa-cal/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "6f9e84348fd4bcc855d2e6f16d53ee0a0df733d73aab42269e0218d52e478f85"
  license "MIT"
  head "https://github.com/damsleth/owa-cal.git", branch: "main"

  depends_on "python@3.12"
  depends_on "damsleth/tap/owa-piggy" => :recommended

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage: owa-cal", shell_output("#{bin}/owa-cal --help")
  end
end
