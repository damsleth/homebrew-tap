class OwaCal < Formula
  include Language::Python::Virtualenv

  desc "Calendar CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/cal-cli"
  url "https://github.com/damsleth/cal-cli/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "5fbff01a8f2267574cdcc6056a63668b437522ed036bbf2c639927c50f8e6dbe"
  license "MIT"
  head "https://github.com/damsleth/cal-cli.git", branch: "main"

  depends_on "python@3.12"
  depends_on "damsleth/tap/owa-piggy" => :recommended

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage: owa-cal", shell_output("#{bin}/owa-cal --help")
  end
end
