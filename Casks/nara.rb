cask "nara" do
  arch arm: "arm64", intel: "x64"

  version "0.3.1"
  sha256 arm:   "c7b402d27ccd39be9a2b2d057eae2d459efa65eadc7461108014bca5579f913d",
         intel: "de5a5b2b41f70b2ae2ec555914d86fa2bf7385f2589f999847a666880f8c7160"

  url "https://github.com/VitorEskes/Nara/releases/download/v#{version}/nara-#{version}-#{arch}.dmg"
  name "Nara"
  desc "Desktop canvas for running teams of coding agents"
  homepage "https://github.com/VitorEskes/Nara"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "Nara.app"

  # Nara isn't notarized yet, so Gatekeeper would refuse to open it once Homebrew has
  # downloaded it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Nara.app"]
  end

  zap trash: [
    "~/Library/Application Support/nara",
    "~/Library/Preferences/dev.vitor.nara.plist",
    "~/Library/Saved Application State/dev.vitor.nara.savedState",
  ]
end
