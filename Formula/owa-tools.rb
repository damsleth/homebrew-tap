class OwaTools < Formula
  include Language::Python::Virtualenv

  desc "Outlook/Microsoft 365 CLI suite (mail, calendar, graph, drive, todo, video)"
  homepage "https://github.com/damsleth/owa-tools"
  url "https://github.com/damsleth/owa-tools/archive/refs/tags/v1.3.0.tar.gz"
  version "1.3.0"
  sha256 "2d2ca8e5544a63c9a2a3bebca41c9924862077543ca11ffbeb275b6376eac760"
  license "MIT"
  head "https://github.com/damsleth/owa-tools.git", branch: "main"

  depends_on "python@3.12"
  depends_on "damsleth/tap/owa-piggy" => :recommended

  def install
    virtualenv_install_with_resources
  end

  test do
    # All thirteen binaries land on PATH and report the same suite version.
    %w[owa owa-cal owa-mail owa-graph owa-doctor owa-people owa-sched owa-drive
       owa-todo owa-planner owa-sites owa-teams owa-vids].each do |bin_name|
      assert_match version.to_s, shell_output("#{bin}/#{bin_name} --version")
    end
    system "#{bin}/owa", "list"
  end
end
