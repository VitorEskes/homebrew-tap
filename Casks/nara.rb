cask "nara" do
  arch arm: "arm64", intel: "x64"

  version "0.3.3"
  sha256 arm:   "acee89a2e1e7c256fa45896a365458e1293d08e0416f7a7819b4e482a8217622",
         intel: "62b99b4dbc9e38e88b9b38b1e8690082e9df41c71a684ad9a78a45607e205c4c"

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
