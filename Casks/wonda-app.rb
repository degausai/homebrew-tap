cask "wonda-app" do
  version "1.61.1"
  sha256 "ab3c10738a5b8d918832f3b2bf947ebf412a7fa5520b8a130ac41bc7ba3dd6d9"

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
