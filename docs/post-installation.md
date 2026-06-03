---
layout: default
title: Post-Installation Guide
description: Complete configuration guide for all installed tools
---

# 📋 Post-Installation Setup Guide

> **Your complete checklist for configuring every tool after installation**

> **Need to (re)install?** Run the one-line installer:
> ```bash
> sh -c "$(curl -fsSL https://raw.githubusercontent.com/allanasp/Setup-Developer-Mac/main/install.sh)"
> ```
> Append `-- --skip-prompts` to run non-interactively, and set the `SETUP_OPTIONAL`
> environment variable to choose which optional scripts run.

## 🚀 Quick Navigation

- [Essential Setup](#essential-setup-everyone) - Required for all users
- [Development Tools](#development-tools) - VS Code, Git, GitHub
- [Frontend Development](#frontend-development) - Package managers, CMS tools
- [Mobile Development](#mobile-development) - Android Studio, Xcode
- [Productivity Apps](#productivity-apps) - Rectangle, Maccy
- [Database Setup](#database-setup) - PostgreSQL, Supabase
- [DevOps & Cloud](#devops--cloud) - ngrok, UpCloud, Kubernetes, command line utilities
- [macOS System Defaults](#macos-system-defaults) - Optional system tweaks
- [Maintenance](#maintenance-update--uninstall) - Update, uninstall, dry-run
- [Troubleshooting](#troubleshooting) - Common issues

---

## Essential Setup (Everyone)

### ✅ Quick Checklist
- [ ] Restart terminal or run `source ~/.zshrc`
- [ ] PowerLevel10k (Dracula colors pre-configured, `p10k configure` optional)
- [ ] Import iTerm2 Dracula theme
- [ ] Set up Git identity
- [ ] Configure primary editor

### 🔄 1. Activate Your Shell

<div class="setup-box">
<h4>Option A: Restart Terminal (Recommended)</h4>
<p>Close all terminal windows and reopen iTerm2</p>

<h4>Option B: Reload Configuration</h4>
<pre><code>source ~/.zshrc</code></pre>
</div>

### ⚡ 2. PowerLevel10k Configuration

**🎨 Dracula colors are pre-configured!** Your prompt already matches your terminal theme.

If you want to customize further, run the configuration wizard:
```bash
p10k configure
```

**Recommended Settings:**
- **Prompt Style:** Lean (minimal) or Classic (more info)
- **Character Set:** Yes to Nerd Fonts
- **Prompt Flow:** Single line (faster)
- **Instant Prompt:** Enable
- **Transient Prompt:** Enable

### 🎨 3. iTerm2 Dracula Theme

1. Open iTerm2 → **Preferences** (`⌘,`)
2. **Profiles** → **Colors**
3. **Color Presets...** → **Import...**
4. Select `Dracula.itermcolors` from setup folder
5. Select **Dracula** from dropdown

**Additional Settings:**
- **General** → Working Directory → "Reuse previous"
- **Keys** → Add shortcuts for word navigation

### ✓ 4. Verify Installation

```bash
# Node.js via Volta
node --version  # Should show LTS
npm --version

# Python via pyenv
python --version  # Should show 3.12.1
pyenv versions

# If needed, set global Python
pyenv global 3.12.1
```

### 🛠️ 5. Modern CLI Tools

The setup installs a set of modern command-line tools. Most work immediately, but a few have useful first-run steps:

```bash
# Prime the tldr cache
tldr --update

# zoxide replaces cd — jump to a directory with `z`
z myproject

# atuin owns Ctrl-R for searchable shell history
# (just press Ctrl-R after restarting your shell)
```

**Available after setup:**
- **git-delta** — syntax-highlighted git diffs (wired in as the git pager)
- **ripgrep** (`rg`) — fast recursive search
- **fd** — friendly `find` replacement
- **bat** — `cat` with syntax highlighting
- **zoxide** (`z`) — smarter `cd` that learns your directories
- **lazygit** — terminal UI for git
- **direnv** — per-directory environment variables
- **atuin** — searchable shell history (owns Ctrl-R)
- **tldr** — simplified man pages (run `tldr --update` first)
- **btop** — resource monitor
- **dust** — `du` replacement for disk usage
- **duf** — `df` replacement for free disk space

---

## Development Tools

### 🆚 VS Code Setup

<div class="config-grid">
<div class="config-card">
<h4>1. Command Line</h4>
<pre><code># Test
code --version

# If broken, fix:
echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc</code></pre>
</div>

<div class="config-card">
<h4>2. Essential Settings</h4>
<p>Open Settings (⌘,) and add:</p>
<pre><code>{
  "editor.fontSize": 14,
  "editor.fontFamily": "'Fira Code', 'JetBrains Mono'",
  "editor.fontLigatures": true,
  "editor.formatOnSave": true,
  "editor.minimap.enabled": false,
  "terminal.integrated.fontFamily": "'Fira Code'"
}</code></pre>
</div>
</div>

**Extension Setup:**
- **GitHub Copilot:** Click icon → Sign in with GitHub

### 🐙 GitHub Configuration

```bash
# Authenticate CLI
gh auth login
# Choose: GitHub.com → HTTPS → Browser → Copy code

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
git config --global init.defaultBranch main
```

> **Already configured:** The setup applies sensible Git defaults and uses **git-delta** as
> the diff pager (no action needed). It also adds a `git lg` alias for a compact, graphical
> commit log.

### 🤖 Cursor AI Setup
1. Open Cursor app
2. Create account at [cursor.sh](https://cursor.sh)
3. Choose plan (free available)
4. Import VS Code settings
5. Enable AI features

---

## Frontend Development

### 📦 Package Manager Setup

```bash
# npm login (if publishing packages)
npm login

# pnpm is installed via Volta and ready to use
pnpm --version

# bun is installed via the oven-sh/bun Homebrew tap
bun --version
```

### 📝 Headless CMS Tools

<div class="setup-grid">
<div class="setup-card">
<h4>Storyblok</h4>
<ol>
<li>Create account: <a href="https://app.storyblok.com/#!/signup">app.storyblok.com</a></li>
<li>Login: <code>storyblok login</code></li>
<li>Create project: <code>storyblok quickstart</code></li>
</ol>
</div>

<div class="setup-card">
<h4>Sanity</h4>
<ol>
<li>Create project: <code>sanity init</code></li>
<li>Choose template</li>
<li>Deploy: <code>sanity deploy</code></li>
</ol>
</div>
</div>

---

## Mobile Development

### 🤖 Android Studio

<div class="mobile-setup">
<h4>1. Setup Wizard</h4>
<ul>
<li>Open Android Studio</li>
<li>Standard installation</li>
<li>Accept all licenses</li>
<li>Download system images</li>
</ul>

<h4>2. SDK Configuration</h4>
<p>Preferences → System Settings → Android SDK</p>
<ul>
<li>Install: Android 14 (API 34), Android 13 (API 33)</li>
<li>SDK Tools: Build-Tools, Platform-Tools, Command-line Tools</li>
</ul>

<h4>3. Create AVD</h4>
<ul>
<li>Tools → AVD Manager → Create</li>
<li>Choose Pixel 6</li>
<li>Select API 34</li>
</ul>

<h4>4. Environment Check</h4>
<pre><code># Verify
echo $ANDROID_HOME
echo $JAVA_HOME

# Fix if needed
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
source ~/.zshrc</code></pre>
</div>

### 🍎 iOS Development

1. **Install Xcode** from App Store (15GB+)
2. Open Xcode, agree to license
3. **Command line setup:**
```bash
sudo xcodebuild -license accept
xcode-select --install
```
4. **Download simulators** in Xcode → Preferences → Components

### ⚛️ React Native Verification

```bash
npx react-native doctor
# Fix any ❌ issues shown
```

### 🚀 Expo + React Native Local Dev (12-expo-rn.sh)

The optional `12-expo-rn.sh` script sets up a full local Expo / React Native
toolchain: **Watchman**, **OpenJDK 17**, **Android Studio**, the **iOS toolchain**,
and **Maestro** for end-to-end mobile testing.

```bash
# Run the Expo / React Native setup script
./scripts/12-expo-rn.sh

# Verify the toolchain
watchman --version
java -version          # OpenJDK 17
maestro --version

# Create and run a new app
npx create-expo-app my-app
cd my-app && npx expo start
```

---

## Productivity Apps

### 🪟 Rectangle Shortcuts

Default shortcuts (customize in preferences):
- `⌘⌥←` Left Half
- `⌘⌥→` Right Half  
- `⌘⌥F` Maximize
- `⌘⌥C` Center


### 📋 Maccy Clipboard

1. Open Maccy → Grant permissions
2. Set hotkey: `⌘⇧V`
3. Enable "Launch at login"
4. Set history size: 200

---

## Database Setup

### 🐘 PostgreSQL

```bash
# Verify running
brew services list | grep postgresql

# Start if needed
brew services start postgresql@15

# Test connection
psql postgres
\q

# Create dev database (optional)
createdb myapp_dev
```

### 🖥️ DBeaver Community Edition

**First Connection:**
- Database: PostgreSQL
- Host: `localhost`  
- Port: `5432`
- Database: `postgres`
- Username: Your Mac username
- Test connection before saving

### ⚡ Supabase

<div class="supabase-setup">
<h4>1. Create Account</h4>
<p>Visit <a href="https://supabase.com">supabase.com</a> → Sign up</p>

<h4>2. Local Development</h4>
<pre><code># Login
supabase login

# Initialize project
supabase init

# Start local stack
supabase start

# Stop when done
supabase stop</code></pre>

<h4>3. Link Remote Project</h4>
<pre><code>supabase link --project-ref your-project-id
supabase db pull</code></pre>
</div>

---

## DevOps & Cloud

### ☁️ UpCloud Setup

1. **Create an UpCloud account** at [upcloud.com](https://upcloud.com)
2. **Enable API access** and create API credentials in the control panel
3. **Configure upctl:**
```bash
# Provide credentials (env vars or upctl config)
export UPCLOUD_USERNAME="your-username"
export UPCLOUD_PASSWORD="your-password"

# Test
upctl account show
upctl server list
```

### ☸️ Kubernetes & Infrastructure

```bash
# kubectl - point at a cluster, then verify
kubectl version --client
kubectl get nodes

# Tilt - fast local dev on Kubernetes
tilt version
tilt up   # from a project with a Tiltfile

# Terraform - infrastructure as code
terraform version
terraform init
terraform plan
```

### 🌐 Command Line Utilities

```bash
# ngrok for local tunneling
ngrok config add-authtoken YOUR_TOKEN
ngrok http 3000  # Share local development server

# JSON processing with jq
echo '{"name": "test"}' | jq '.name'
curl api.example.com | jq '.data[]'

# Better file operations
eza -la          # Modern ls replacement
tree -L 2        # Directory structure
fzf              # Fuzzy file finder
```

### 🐳 OrbStack (Docker)

1. Open OrbStack → Complete setup
2. Test Docker:
```bash
docker --version
docker run hello-world
```

### 🌐 ngrok

1. Create account at [ngrok.com](https://ngrok.com)
2. Get auth token from dashboard
3. Configure:
```bash
ngrok config add-authtoken YOUR_TOKEN

# Test
ngrok http 3000
```

---

## macOS System Defaults

The optional `13-macos-defaults.sh` script applies sensible macOS system tweaks: faster
key repeat, Finder improvements, screenshots routed to `~/Screenshots`, and Dock
adjustments.

```bash
# Apply the macOS system defaults
./scripts/13-macos-defaults.sh
```

> **Log out or restart** after running this script so all changes take full effect.

---

## Maintenance: Update & Uninstall

Keep your environment current or roll it back with the repo helper scripts:

```bash
# Upgrade everything (Homebrew, Volta, Oh My Zsh, PowerLevel10k)
./update.sh

# Roll back what the setup installed
./uninstall.sh
```

> **Preview first:** Pass `--dry-run` to `setup.sh`, `update.sh`, or `uninstall.sh` to see
> what would happen without making changes.

Each `setup.sh` run is logged to `~/mac-setup-YYYY-MM-DD.log` and prints an install summary
when it finishes.

---

## Troubleshooting

### Common Issues

<div class="troubleshooting-grid">
<div class="issue-card">
<h4>Command Not Found</h4>
<pre><code>source ~/.zshrc
# Or restart terminal</code></pre>
</div>

<div class="issue-card">
<h4>VS Code 'code' Command</h4>
<pre><code>echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc</code></pre>
</div>

<div class="issue-card">
<h4>ANDROID_HOME Missing</h4>
<pre><code>echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
source ~/.zshrc</code></pre>
</div>

<div class="issue-card">
<h4>PostgreSQL Not Starting</h4>
<pre><code>brew services restart postgresql@15
tail -f /opt/homebrew/var/log/postgresql@15.log</code></pre>
</div>
</div>

### PowerLevel10k Icons Missing
- Run `p10k configure` again
- Install recommended fonts
- Or choose ASCII-compatible options

### GitHub CLI Auth Failed
- Run `gh auth logout` then `gh auth login`
- Copy the full one-time code
- Check firewall settings

---

## Verification Commands

```bash
# Quick system check
node --version && npm --version && python --version
git config --get user.name && gh auth status
code --version && docker --version

# Full verification
./check-setup.sh
```

---

## 🎯 Next Steps

### Start Building!

**Frontend Project:**
```bash
npm create vite@latest my-app
cd my-app && npm install && npm run dev
```

**Mobile App:**
```bash
npx create-expo-app my-app
cd my-app && npx expo start
```

**Full Stack:**
```bash
npx create-next-app@latest my-app
cd my-app && supabase init
```

---

<div class="success-banner">
<h2>🎉 You're All Set!</h2>
<p>Your development environment is ready. Start building amazing things!</p>
<ul>
<li>Learn keyboard shortcuts</li>
<li>Customize your tools</li>
<li>Join tool communities</li>
<li>Keep everything updated with <code>brew upgrade</code></li>
</ul>
</div>

---

**[← Back to Home](index.html)** | **[Tools Guide →](tools-guide.html)** | **[Script Guide →](script-guide.html)**

<style>
.setup-box {
  background: #f6f8fa;
  border: 1px solid #d1d5da;
  border-radius: 6px;
  padding: 1rem;
  margin: 1rem 0;
}

.config-grid, .setup-grid, .productivity-grid, .troubleshooting-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1rem;
  margin: 1rem 0;
}

.config-card, .setup-card, .prod-card, .issue-card {
  background: #f6f8fa;
  border: 1px solid #d1d5da;
  border-radius: 6px;
  padding: 1rem;
}

.mobile-setup, .supabase-setup {
  background: #f1f8ff;
  border: 1px solid #c8e1ff;
  border-radius: 6px;
  padding: 1rem;
  margin: 1rem 0;
}

.success-banner {
  background: #28a745;
  color: white;
  padding: 2rem;
  border-radius: 8px;
  text-align: center;
  margin: 2rem 0;
}

.success-banner h2 {
  color: white;
  margin: 0 0 1rem 0;
}

.success-banner ul {
  list-style: none;
  padding: 0;
}

.success-banner li {
  margin: 0.5rem 0;
}

pre {
  background: #f6f8fa;
  border: 1px solid #d1d5da;
  border-radius: 4px;
  padding: 0.5rem;
  overflow-x: auto;
}

code {
  background: #f6f8fa;
  padding: 0.2rem 0.4rem;
  border-radius: 3px;
  font-size: 0.9em;
}

h4 {
  color: #24292e;
  margin-top: 0;
}
</style>