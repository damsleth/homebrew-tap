class OwaCal < Formula
  include Language::Python::Virtualenv

  desc "Calendar CLI for Outlook / Microsoft 365"
  homepage "https://github.com/damsleth/owa-cal"
  url "https://github.com/damsleth/owa-cal/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "8b04381179c11b6fcf2ac413264614fea76d9145ac0ab09409800870f99bd350"
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
