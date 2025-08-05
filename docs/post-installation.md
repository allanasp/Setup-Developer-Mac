---
layout: default
title: Post-Installation Guide
description: Complete configuration guide for all installed tools
---

# 📋 Post-Installation Setup Guide

> **Your complete checklist for configuring every tool after installation**

## 🚀 Quick Navigation

- [Essential Setup](#essential-setup-everyone) - Required for all users
- [Development Tools](#development-tools) - VS Code, Git, GitHub
- [Frontend Development](#frontend-development) - Package managers, CMS tools
- [Mobile Development](#mobile-development) - Android Studio, Xcode
- [Productivity Apps](#productivity-apps) - Raycast, Rectangle, 1Password
- [Database Setup](#database-setup) - PostgreSQL, Supabase
- [DevOps & Cloud](#devops--cloud) - AWS, Kubernetes, Docker
- [Troubleshooting](#troubleshooting) - Common issues

---

## Essential Setup (Everyone)

### ✅ Quick Checklist
- [ ] Restart terminal or run `source ~/.zshrc`
- [ ] Configure PowerLevel10k (`p10k configure`)
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

Run the configuration wizard:
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
- **AWS Toolkit:** Click AWS icon → Add Connection → Follow prompts

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

# Configure Yarn Berry (optional)
yarn set version berry

# Setup pnpm
pnpm setup
source ~/.zshrc
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

---

## Productivity Apps

### 🔍 Raycast Setup

<div class="productivity-grid">
<div class="prod-card">
<h4>1. Initial Setup</h4>
<ul>
<li>Open Raycast</li>
<li>Grant permissions</li>
<li>Disable Spotlight: System Prefs → Keyboard → Shortcuts</li>
<li>Set Raycast to ⌘Space</li>
</ul>
</div>

<div class="prod-card">
<h4>2. Essential Extensions</h4>
<p>Open Store (⌘Space → "store")</p>
<ul>
<li>GitHub</li>
<li>Homebrew</li>
<li>Kill Process</li>
<li>Clipboard History</li>
<li>VSCode Projects</li>
</ul>
</div>
</div>

### 🪟 Rectangle Shortcuts

Default shortcuts (customize in preferences):
- `⌘⌥←` Left Half
- `⌘⌥→` Right Half  
- `⌘⌥F` Maximize
- `⌘⌥C` Center

### 🔐 1Password

1. Open 1Password → Sign in/Create account
2. Save Emergency Kit securely
3. Install browser extensions
4. Enable SSH agent for developer keys

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

### 🖥️ Sequel Ace

**First Connection:**
- Host: `127.0.0.1`
- Username: Your Mac username
- Port: `5432`
- Database: `postgres`

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

### ☁️ AWS Setup

1. **Create AWS Account** at [aws.amazon.com](https://aws.amazon.com)
2. **Create IAM User:**
   - Console → IAM → Users → Add
   - Enable programmatic access
   - Save credentials

3. **Configure CLI:**
```bash
aws configure
# Enter: Access Key, Secret Key, Region (us-east-1), Format (json)

# Test
aws sts get-caller-identity
```

### ☸️ Kubernetes

```bash
# If you have a cluster
aws eks update-kubeconfig --name cluster-name

# Context management
kubectx              # List contexts
kubectx production   # Switch context
kubens backend       # Switch namespace

# Aliases
echo 'alias k=kubectl' >> ~/.zshrc
echo 'alias kgp="kubectl get pods"' >> ~/.zshrc
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