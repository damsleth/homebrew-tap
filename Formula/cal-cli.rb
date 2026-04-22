class CalCli < Formula
  include Language::Python::Virtualenv

  desc "Calendar CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/cal-cli"
  url "https://github.com/damsleth/cal-cli/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "8c67d4be66b0468d5ec237f4e74a80cb25a0d0471eb4233e81e3775c5728fdbe"
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
