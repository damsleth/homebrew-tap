class OwaTools < Formula
  include Language::Python::Virtualenv

  desc "Outlook / Microsoft 365 CLI suite (cal, mail, graph, doctor, people, sched, drive)"
  homepage "https://github.com/damsleth/owa-tools"
  url "https://github.com/damsleth/owa-tools/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "7e52745b393f8e7245763d6a99f33b3d34cc4ca5c84447eaabffbf4b1a5400c3"
  license "MIT"
  version "0.1.3"
  head "https://github.com/damsleth/owa-tools.git", branch: "main"

  depends_on "python@3.12"
  depends_on "damsleth/tap/owa-piggy" => :recommended

  def install
    virtualenv_install_with_resources
  end

  test do
    %w[owa owa-cal owa-mail owa-graph owa-doctor owa-people owa-sched owa-drive].each do |bin_name|
      assert_match version.to_s, shell_output("#{bin}/#{bin_name} --version")
    end
    system "#{bin}/owa", "list"
    system "#{bin}/owa", "doctor", "--no-tokens"
  end
end
