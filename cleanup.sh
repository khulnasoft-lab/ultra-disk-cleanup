#!/bin/bash
set -euo pipefail

debug="${1:-false}"

log() {
  [[ "$debug" == "true" ]] && echo "::debug::$1"
}

print_space() {
  echo ""
  df -h /
  echo ""
}

initial=$(df / --output=avail | tail -n1)
log "Initial available space: $initial"

print_space
log "🧹 Starting cleanup..."

sudo systemctl stop docker || true
sudo docker system prune -af || true
sudo rm -rf /var/lib/docker || true

sudo rm -rf /usr/local/lib/android /opt/hostedtoolcache/Android "$HOME/.android"
sudo rm -rf /opt/ghc /usr/local/.ghcup
sudo rm -rf /usr/local/cargo /usr/local/rustup "$HOME/.cargo" "$HOME/.rustup"
sudo rm -rf /usr/share/dotnet
sudo rm -rf /opt/az "$AGENT_TOOLSDIRECTORY" || true

rm -rf "$HOME/.npm" "$HOME/.cache/pip" "$HOME/.gem" "$HOME/.yarn" "$HOME/.nvm" || true
sudo apt-get clean && sudo apt-get autoclean && sudo apt-get autoremove -y
sudo rm -rf /usr/share/locale/* /usr/share/man/* /usr/share/doc/*
sudo find /var/log -type f -delete || true
sudo rm -rf /var/crash/* /tmp/* "$HOME/.cache/*" /var/tmp/* || true
sudo swapoff -a || true
sudo rm -f /mnt/swapfile || true

sudo find / -type f -size +100M -not -path "/proc/*" -not -path "/sys/*" -exec rm -f {} \; 2>/dev/null || true

log "Cleanup done."

final=$(df / --output=avail | tail -n1)
saved=$((final - initial))
saved_bytes=$((saved * 1024))
echo "💾 Saved: $(numfmt --to=iec $saved_bytes)"
echo "saved-space=$saved_bytes" >> "$GITHUB_OUTPUT"

echo "### 🧼 Ultra Disk Cleanup Complete" >> "$GITHUB_STEP_SUMMARY"
echo "- Saved: $(numfmt --to=iec $saved_bytes)" >> "$GITHUB_STEP_SUMMARY"

print_space
