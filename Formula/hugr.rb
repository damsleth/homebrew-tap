class Hugr < Formula
  include Language::Python::Virtualenv

  desc "Meta-CLI and suite hub for the hugr memory suite"
  homepage "https://github.com/damsleth/hugr"
  # The hugr repo is private and not published to PyPI, so this formula
  # fetches the tagged commit over SSH. It installs only for accounts with
  # read access to github.com/damsleth/hugr (i.e. the maintainer). When
  # hugr is published to a public repo or PyPI, swap this to a tarball +
  # sha256 like the owa-tools formula.
  url "git@github.com:damsleth/hugr.git",
      tag:      "v0.4.1",
      revision: "7c98f2509becee6afa3e922cbba6adb45ef20612"
  license "MIT"
  head "git@github.com:damsleth/hugr.git", branch: "main"

  # The suite's underlying tools. hugr invokes them as subprocesses
  # over its translation table; it does not import them, so the
  # version pins are minimums for contract conformance (--doctor
  # JSON schema, --json on data/action commands) rather than ABI
  # compatibility.
  depends_on "damsleth/tap/cognitive-ledger" => ">= 0.2.0"
  depends_on "damsleth/tap/owa-piggy" => ">= 0.9.0"
  depends_on "damsleth/tap/owa-tools" => ">= 0.1.1"
  depends_on "damsleth/tap/yaams" => ">= 0.1.2"
  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/9b/98/518d8e5081007684232226f475082b30087d0f585e8457db087298259f49/click-8.4.1.tar.gz"
    sha256 "918b5633eddf6b41c32d4f454bf0de810065c74e3f7dbf8ee5452f8be88d3e96"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      hugr is installed. The router pulled in:
        yaams, cognitive-ledger, owa-piggy, owa-tools

      First-time setup:
        hugr hello              # see what the suite exposes
        hugr doctor             # check that every component is healthy

      Bootstrap on a fresh machine:
        hugr init               # interactive wizard, detects sources

      Power users can still call the underlying CLIs directly
      (`yaams query`, `ledger query`, `owa-cal events`, etc.) - they
      produce the same JSON shapes hugr aggregates.
    EOS
  end

  test do
    assert_match "hugr", shell_output("#{bin}/hugr --version")
    # `hugr doctor` may exit nonzero on a fresh install (binaries
    # missing on PATH); just check the binary itself runs.
    assert_match "hugr", shell_output("#{bin}/hugr hello --json")
  end
end
