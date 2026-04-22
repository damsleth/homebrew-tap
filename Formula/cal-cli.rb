class CalCli < Formula
  include Language::Python::Virtualenv

  desc "Calendar CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/cal-cli"
  url "https://github.com/damsleth/cal-cli/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "43207d088b803b51113b0dffda8315db5d77d4f683eb949ed53dc7ab43ab585e"
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
