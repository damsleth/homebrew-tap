class CognitiveLedger < Formula
  include Language::Python::Virtualenv

  desc "File-based, hybrid markdown+embeddings memory system for AI agents"
  homepage "https://github.com/damsleth/cognitive-ledger"
  url "https://github.com/damsleth/cognitive-ledger/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "25319ac3ddd1feef45b970a1755900c69771bc6f83fea1010c5f39f51845dba6"
  license "MIT"
  head "https://github.com/damsleth/cognitive-ledger.git", branch: "main"

  depends_on "python@3.12"

  def install
    # Create an isolated venv (no --system-site-packages so dev installs don't leak)
    # and let pip resolve the runtime dependency tree from PyPI. This avoids the
    # need to vendor every transitive resource (numpy, scikit-learn, scipy, ...).
    virtualenv_create(libexec, "python3.12", system_site_packages: false)
    # virtualenv_create uses --without-pip; bootstrap pip from stdlib then let
    # it resolve the full runtime dependency tree from PyPI.
    system libexec/"bin/python", "-m", "ensurepip", "--upgrade"
    system libexec/"bin/python", "-m", "pip", "install", "--prefer-binary", buildpath
    bin.install_symlink libexec/"bin/ledger-obsidian"

    # Bundle non-Python assets users will reference post-install
    pkgshare.install "templates", "schema.yaml", "config.sample.yaml", "AGENTS.md"
    pkgshare.install "scripts/hooks" => "hooks"

    # Install loose scripts that aren't console_scripts (ledger, sheep, ledger_ab)
    # Wrap each so it runs with the venv's Python and resolves the ledger package.
    libexec_scripts = libexec/"scripts"
    libexec_scripts.install "scripts/ledger", "scripts/sheep", "scripts/ledger_ab"

    venv_python = "#{libexec}/bin/python"

    (bin/"ledger").write <<~SH
      #!/bin/bash
      exec "#{venv_python}" "#{libexec_scripts}/ledger" "$@"
    SH
    (bin/"ledger").chmod 0755

    (bin/"ledger-ab").write <<~SH
      #!/bin/bash
      exec "#{venv_python}" "#{libexec_scripts}/ledger_ab" "$@"
    SH
    (bin/"ledger-ab").chmod 0755

    # `sheep` already shells out to python -m ledger.maintenance; point it at the venv.
    (bin/"sheep").write <<~SH
      #!/bin/bash
      exec "#{venv_python}" -m ledger.maintenance "$@"
    SH
    (bin/"sheep").chmod 0755
  end

  def caveats
    <<~EOS
      Cognitive Ledger installed. Bundled assets live under:
        #{opt_pkgshare}

      To bootstrap a ledger against your notes tree:
        ledger init --ledger-notes-dir ~/Code/ledger-notes --source-notes-dir ~/Code/notes

      The /notes agent skill is maintained separately:
        https://github.com/damsleth/SKILLS

      Optional environment overrides:
        LEDGER_ROOT, LEDGER_NOTES_DIR, LEDGER_SOURCE_NOTES_DIR

      The local-embeddings extra (sentence-transformers + torch) is NOT installed
      by default. Use OpenAI embeddings, or install the heavy stack manually:
        #{opt_libexec}/bin/pip install 'sentence-transformers>=5.0'
    EOS
  end

  test do
    assert_match "ledger", shell_output("#{bin}/ledger --help")
    assert_match "usage", shell_output("#{bin}/ledger-obsidian --help").downcase
  end
end
