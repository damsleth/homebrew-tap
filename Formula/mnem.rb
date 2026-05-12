class Mnem < Formula
  include Language::Python::Virtualenv

  desc "Meta-CLI and suite hub for the mnem memory suite"
  homepage "https://github.com/damsleth/mnem"
  url "https://github.com/damsleth/mnem/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "8432c66efa7951f6766e548205a0902a29a7e23d81d75d1f9055838c212f6778"
  license "MIT"
  head "https://github.com/damsleth/mnem.git", branch: "main"

  depends_on "python@3.12"

  # The suite's underlying tools. mnem invokes them as subprocesses
  # over its translation table; it does not import them, so the
  # version pins are minimums for contract conformance (--doctor
  # JSON schema, --json on data/action commands) rather than ABI
  # compatibility.
  depends_on "damsleth/tap/yaams" => ">= 0.1.2"
  depends_on "damsleth/tap/cognitive-ledger" => ">= 0.2.0"
  depends_on "damsleth/tap/owa-piggy" => ">= 0.9.0"
  depends_on "damsleth/tap/owa-tools" => ">= 0.1.1"

  resource "click" do
    url "https://files.pythonhosted.org/packages/source/c/click/click-8.1.7.tar.gz"
  end

  def install
    virtualenv_create(libexec, "python3.12", system_site_packages: false)
    system libexec/"bin/python", "-m", "ensurepip", "--upgrade"
    system libexec/"bin/python", "-m", "pip", "install", "--prefer-binary", buildpath
    bin.install_symlink libexec/"bin/mnem"
  end

  def caveats
    <<~EOS
      mnem is installed. The router pulled in:
        yaams, cognitive-ledger, owa-piggy, owa-tools

      First-time setup:
        mnem hello              # see what the suite exposes
        mnem doctor             # check that every component is healthy

      Bootstrap on a fresh machine (Phase 3b):
        mnem init               # interactive wizard, detects sources

      Power users can still call the underlying CLIs directly
      (`yaams query`, `ledger query`, `owa-cal events`, etc.) - they
      produce the same JSON shapes mnem aggregates.
    EOS
  end

  test do
    assert_match "mnem", shell_output("#{bin}/mnem --version")
    # `mnem doctor` may exit nonzero on a fresh install (binaries
    # missing on PATH); just check the binary itself runs.
    assert_match "mnem", shell_output("#{bin}/mnem hello --json")
  end
end
