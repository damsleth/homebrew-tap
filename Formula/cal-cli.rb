class CalCli < Formula
  include Language::Python::Virtualenv

  desc "Calendar CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/cal-cli"
  url "https://github.com/damsleth/cal-cli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "7315d61e2d77608d899f0a02897c06666b74205248aa66a307ac68d5934b91e9"
  license "WTFPL"
  head "https://github.com/damsleth/cal-cli.git", branch: "main"

  depends_on "python@3.12"
  depends_on "damsleth/tap/owa-piggy" => :recommended

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage: cal-cli", shell_output("#{bin}/cal-cli --help")
  end
end
