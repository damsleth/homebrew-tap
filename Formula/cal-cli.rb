class CalCli < Formula
  include Language::Python::Virtualenv

  desc "Calendar CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/cal-cli"
  url "https://github.com/damsleth/cal-cli/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "5066baa0d798e8939ba7e8a2cca4437443b203b37ce37ff61f04348a07af0bc5"
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
