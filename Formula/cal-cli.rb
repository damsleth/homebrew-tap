class CalCli < Formula
  include Language::Python::Virtualenv

  desc "Calendar CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/cal-cli"
  url "https://github.com/damsleth/cal-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "68e776fd3090eacd1022ab5d2ea59a53ab763ab85bf1fac8b2b2a50ea6d98d64"
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
