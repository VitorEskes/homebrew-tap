cask "nara" do
  arch arm: "arm64", intel: "x64"

  version "0.3.0"
  sha256 arm:   "442cf755fa24f7706465502b97f1f5adcc0b74423ce471b20e02d0fad969ace3",
         intel: "88918859f19b2f762552c858a511d1be8adf2b2450b637efdb485f3ee3e862f6"

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
