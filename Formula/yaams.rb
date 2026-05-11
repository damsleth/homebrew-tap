class Yaams < Formula
  include Language::Python::Virtualenv

  desc "Local-first, high-recall personal memory store for messages, mail, and notes"
  homepage "https://github.com/damsleth/yaams"
  url "https://github.com/damsleth/yaams/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5cbd664d5ee3bde687a5bf58a0530627d2760996bf8a4b13616a29cffb8670e8"
  license "MIT"
  head "https://github.com/damsleth/yaams.git", branch: "main"

  depends_on "python@3.12"
  # spaCy and sentence-transformers pull in compiled wheels (numpy, scikit-learn,
  # blis, torch). Mac users get arm64 wheels from PyPI; nothing builds from source
  # under normal conditions.
  depends_on macos: :big_sur

  def install
    # Isolated venv. pip resolves the runtime dependency tree from PyPI rather
    # than us vendoring every transitive resource (torch, spacy models, etc).
    virtualenv_create(libexec, "python3.12", system_site_packages: false)
    system libexec/"bin/python", "-m", "ensurepip", "--upgrade"
    system libexec/"bin/python", "-m", "pip", "install", "--prefer-binary", buildpath

    # Console script declared in pyproject.toml [project.scripts]
    bin.install_symlink libexec/"bin/yaams"

    # Bundle config templates and the launchd plist template so users can copy
    # them out of the install prefix instead of needing the repo.
    pkgshare.install "config.yaml.example", "AGENTS.md"
    pkgshare.install "scripts/local.yaams.ingest.plist.example"
    pkgshare.install "docs"
  end

  def caveats
    <<~EOS
      YAAMS is installed. Bundled templates live under:
        #{opt_pkgshare}

      First-time setup:
        mkdir -p ~/.config/yaams
        cp #{opt_pkgshare}/config.yaml.example ~/.config/yaams/config.yaml
        $EDITOR ~/.config/yaams/config.yaml
        yaams init-db
        yaams ingest --dry-run

      Then a real ingest:
        yaams ingest

      The first ingest run downloads the embedding model (BAAI/bge-m3, ~2GB).
      YAAMS prompts before downloading; subsequent runs are fully offline.

      The spaCy multilingual NER model is required and not bundled:
        #{opt_libexec}/bin/python -m spacy download xx_ent_wiki_sm

      Nightly scheduling: see #{opt_pkgshare}/docs/scheduling.md and copy
      #{opt_pkgshare}/local.yaams.ingest.plist.example into
      ~/Library/LaunchAgents/, filling in your username and YAAMS_CONFIG path.

      Read SECURITY.md before pointing this at sensitive personal data:
        https://github.com/damsleth/yaams/blob/main/SECURITY.md
    EOS
  end

  test do
    assert_match "yaams", shell_output("#{bin}/yaams --version")
    assert_match version.to_s, shell_output("#{bin}/yaams --version")
  end
end
