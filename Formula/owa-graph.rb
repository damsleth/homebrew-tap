class OwaGraph < Formula
  include Language::Python::Virtualenv

  desc "Pipe-friendly Microsoft Graph CLI - one-off Graph queries with owa-piggy auth"
  homepage "https://github.com/damsleth/owa-graph"
  url "https://github.com/damsleth/owa-graph/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a854476d9bdc277c62c944f39c54c52f2963c597c4c9d9e7be8d827ba5ed10aa"
  license "MIT"
  head "https://github.com/damsleth/owa-graph.git", branch: "main"

  depends_on "python@3.12"
  depends_on "damsleth/tap/owa-piggy" => :recommended

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage: owa-graph", shell_output("#{bin}/owa-graph --help")
  end
end
