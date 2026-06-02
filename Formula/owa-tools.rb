class OwaTools < Formula
  include Language::Python::Virtualenv

  desc "Outlook/Microsoft 365 CLI suite (mail, calendar, graph, drive, todo)"
  homepage "https://github.com/damsleth/owa-tools"
  url "https://github.com/damsleth/owa-tools/archive/refs/tags/v0.7.0.tar.gz"
  version "0.7.0"
  sha256 "4a6534ba3a9c9b866df428366662eaa158f8b77d8a98fb98ab655816b7c41fa8"
  license "MIT"
  head "https://github.com/damsleth/owa-tools.git", branch: "main"

  depends_on "python@3.12"
  depends_on "damsleth/tap/owa-piggy" => :recommended

  def install
    virtualenv_install_with_resources
  end

  test do
    # All twelve binaries land on PATH and report the same suite version.
    %w[owa owa-cal owa-mail owa-graph owa-doctor owa-people owa-sched owa-drive
       owa-todo owa-planner owa-sites owa-teams].each do |bin_name|
      assert_match version.to_s, shell_output("#{bin}/#{bin_name} --version")
    end
    system "#{bin}/owa", "list"
  end
end
