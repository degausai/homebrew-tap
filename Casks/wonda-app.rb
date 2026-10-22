cask "wonda-app" do
  version "1.70.0"
  sha256 "7f080c340fbec87c702ffb9202e660a7f67b32ed291d450f780fd63987ed3d57"

  url "https://github.com/degausai/wonda/releases/download/v#{version}/wonda-macos.pkg"
  name "Wonda"
  desc "Wonda desktop app: CLI, menu bar icon, and always-on relay"
  homepage "https://wonda.sh"

  livecheck do
    url "https://github.com/degausai/wonda"
    strategy :github_latest
  end

  pkg "wonda-macos.pkg"

  uninstall script:    {
              executable:   "/usr/local/bin/wonda",
              args:         ["app", "quit"],
              must_succeed: false,
            },
            login_item: "Wonda",
            launchctl:  "sh.wonda.relay",
            pkgutil:    "sh.wonda.cli",
            delete:     [
              "/Applications/Wonda.app",
              "/Library/Application Support/Wonda",
              "/usr/local/bin/wonda",
            ]

  zap trash: [
        "~/.wonda",
        "~/Library/LaunchAgents/sh.wonda.relay.plist",
        "~/Library/Logs/wonda-relay.log",
      ]
end
