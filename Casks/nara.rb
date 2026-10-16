cask "nara" do
  arch arm: "arm64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "704d127212f406547224a61c27490d448832b1b5024c6d7738d8a7dafb45cf7e",
         intel: "c2355ac2da9db014c3898112ff31c1561b23fb9ea6de33d14bcf63550601fef0"

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
