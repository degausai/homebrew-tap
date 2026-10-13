cask "wonda-app" do
  version "1.69.4"
  sha256 "d2239e02bab501c3bfbb8d4ba0c81d36a8a005029b5867305c5fdf0322fc6b1a"

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
