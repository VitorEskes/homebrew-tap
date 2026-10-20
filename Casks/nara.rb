cask "nara" do
  arch arm: "arm64", intel: "x64"

  version "0.3.4"
  sha256 arm:   "648373dd737b582ce9975b126e444d54b3d562023c3c35f0fd6f979519c0d89e",
         intel: "f46065449a24a4a53276ee01fd5e247d31ac7c76718b8f4c52e5e7243a90ce1d"

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
