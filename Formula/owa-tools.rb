class OwaTools < Formula
  include Language::Python::Virtualenv

  desc "Outlook / Microsoft 365 CLI suite (cal, mail, graph, doctor, people, sched, drive)"
  homepage "https://github.com/damsleth/owa-tools"
  url "https://github.com/damsleth/owa-tools/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "115abaef166c57dd5254653cd05ae00c78da99d3584ec22e1b3f71348721825e"
  license "MIT"
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
