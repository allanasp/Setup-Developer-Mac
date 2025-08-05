# 📋 Complete Post-Installation Setup Guide

> **Essential configuration steps, account setups, and tool activation after running the scripts**

This guide walks you through every configuration step needed to fully activate your development environment. Follow the sections based on which scripts you installed.

## 🚀 Quick Start Checklist

**Essential for Everyone:**
- [ ] Restart terminal or `source ~/.zshrc`
- [ ] Configure PowerLevel10k theme
- [ ] Import iTerm2 Dracula theme
- [ ] Set up GitHub authentication
- [ ] Configure your primary code editor

**Based on Your Installation:**
- [ ] Set up cloud accounts (AWS, Supabase)
- [ ] Configure productivity apps (Raycast, Rectangle)
- [ ] Set up mobile development (Android Studio, Xcode)
- [ ] Initialize database tools
- [ ] Configure DevOps tools

---

## 🔧 Essential Configuration (Scripts 1-3)

### 1. Activate Shell Changes
```bash
# Option 1: Restart terminal completely (recommended)
# Close all terminal windows and reopen

# Option 2: Reload configuration
source ~/.zshrc
```

### 2. Configure PowerLevel10k Theme
```bash
# Run the configuration wizard
p10k configure
```

**Configuration recommendations:**
- **Prompt Style**: Choose "Lean" for minimal or "Classic" for more info
- **Character Set**: Install recommended fonts when prompted
- **Prompt Flow**: Single line (faster) or two lines (cleaner)
- **Instant Prompt**: Enable for faster terminal startup
- **Transient Prompt**: Enable to clean up old commands

### 3. Import iTerm2 Dracula Theme
1. Open **iTerm2**
2. Press `⌘,` to open Preferences
3. Go to **Profiles** → **Colors** tab
4. Click **Color Presets...** dropdown (bottom right)
5. Select **Import...**
6. Navigate to your setup folder and select `Dracula.itermcolors`
7. Select **Dracula** from the Color Presets dropdown

**Additional iTerm2 Setup:**
- **Profiles** → **General** → Working Directory → "Reuse previous session's directory"
- **Profiles** → **Keys** → Key Mappings → Set up word navigation (Option+← / →)
- **Appearance** → **General** → Theme: "Minimal" for clean look

### 4. Verify Version Managers
```bash
# Check Node.js (via Volta)
node --version    # Should show LTS version
npm --version     # Should be latest

# Check Python (via pyenv)
python --version  # Should show 3.12.1
pip --version     # Should be available

# Set global Python version if needed
pyenv global 3.12.1
```

---

## 💻 Development Apps Configuration (Script 6)

### VS Code Initial Setup

#### 1. Command Line Integration
```bash
# Verify 'code' command works
code --version

# If not, add to PATH manually:
echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

#### 2. Essential Settings
Open VS Code settings (`⌘,`) and configure:
```json
{
  "editor.fontSize": 14,
  "editor.fontFamily": "'Fira Code', 'JetBrains Mono', Menlo, Monaco",
  "editor.fontLigatures": true,
  "editor.formatOnSave": true,
  "editor.minimap.enabled": false,
  "editor.lineHeight": 1.5,
  "terminal.integrated.fontFamily": "'Fira Code', 'JetBrains Mono'",
  "workbench.startupEditor": "none",
  "files.autoSave": "afterDelay"
}
```

#### 3. Extension Configuration
**GitHub Copilot:**
1. Click Copilot icon in sidebar
2. Sign in with GitHub account
3. Authorize GitHub Copilot

**AWS Toolkit (Amazon Q):**
1. Click AWS icon in sidebar
2. Click "Add Connection"
3. Choose authentication method
4. Follow prompts to connect AWS account

### GitHub CLI Authentication
```bash
# Authenticate with GitHub (required for many operations)
gh auth login

# Choose these options:
# ? What account do you want to log into? GitHub.com
# ? What is your preferred protocol? HTTPS
# ? How would you like to authenticate? Login with a web browser
# ? Copy your one-time code: XXXX-XXXX

# Verify authentication
gh auth status
```

### Git Configuration
```bash
# Set your identity (required for commits)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Set default branch name
git config --global init.defaultBranch main

# Enable helpful features
git config --global pull.rebase false
git config --global fetch.prune true

# Optional: Set your preferred editor
git config --global core.editor "code --wait"
```

### Cursor AI Editor Setup
1. Open **Cursor** app
2. Sign in or create account at [cursor.sh](https://cursor.sh)
3. Choose subscription plan (free tier available)
4. Import VS Code settings if desired
5. Enable AI features in settings

---

## 🌐 Frontend Tools Configuration (Script 5)

### Create npm Account (If Needed)
```bash
# Create account at https://www.npmjs.com/signup
# Then login locally:
npm login
```

### Initialize Package Managers
```bash
# Set npm registry (if using private registry)
npm config set registry https://registry.npmjs.org/

# Configure Yarn Berry (if you prefer Yarn)
yarn set version berry
yarn config set nodeLinker node-modules

# Configure pnpm
pnpm setup
source ~/.zshrc
```

### Storyblok CMS Setup
1. Create account at [app.storyblok.com](https://app.storyblok.com/#!/signup)
2. Login locally:
```bash
storyblok login
# Opens browser for authentication
```
3. Create first space:
```bash
storyblok quickstart
```

### Sanity CMS Setup
1. Create account during first project:
```bash
# Create new project (will prompt for login)
sanity init

# Or login first:
sanity login
```
2. Choose project template
3. Deploy Sanity Studio:
```bash
sanity deploy
```

---

## 📱 Mobile Development Setup (Script 7)

### Android Studio Configuration

#### 1. Complete Setup Wizard
1. Open **Android Studio**
2. Follow "Setup Wizard":
   - Standard installation
   - Accept all licenses
   - Download system images

#### 2. Configure SDK
1. **Android Studio** → **Preferences** → **Appearance & Behavior** → **System Settings** → **Android SDK**
2. Install these SDK Platforms:
   - Android 14 (API 34)
   - Android 13 (API 33)
3. Install SDK Tools:
   - Android SDK Build-Tools
   - Android SDK Platform-Tools
   - Android SDK Command-line Tools
   - Android Emulator
   - Intel x86 Emulator Accelerator (HAXM)

#### 3. Create Android Virtual Device (AVD)
1. **Tools** → **AVD Manager**
2. Click **Create Virtual Device**
3. Choose device (e.g., Pixel 6)
4. Select system image (API 34 recommended)
5. Name your AVD
6. Click **Finish**

#### 4. Environment Verification
```bash
# Check environment variables
echo $ANDROID_HOME
# Should output: /Users/[username]/Library/Android/sdk

echo $JAVA_HOME
# Should output: /Library/Java/JavaVirtualMachines/openjdk-21.jdk/Contents/Home

# Add to PATH if missing
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.zshrc
source ~/.zshrc
```

### iOS Development Setup

#### 1. Install Xcode
1. Open **App Store**
2. Search for **Xcode**
3. Click **Get** (15+ GB download, takes time)
4. Open Xcode after installation
5. Agree to license agreement
6. Wait for additional components to install

#### 2. Command Line Tools
```bash
# Accept Xcode license
sudo xcodebuild -license accept

# Install additional tools
xcode-select --install

# Verify installation
xcodebuild -version
```

#### 3. iOS Simulator Setup
1. Open **Xcode** → **Preferences** → **Components**
2. Download iOS simulators you need
3. Or via command line:
```bash
xcodes simulators install "iOS 17.0"
```

### React Native Doctor
```bash
# Run diagnostic tool
npx react-native doctor

# Fix any issues it finds:
# ✓ Node.js - Already configured
# ✓ npm - Already configured  
# ✓ Watchman - Already installed
# ✓ Xcode - Must be installed manually
# ✓ Android Studio - Should be configured
# ✓ Android SDK - Should be configured
# ✓ ANDROID_HOME - Should be set
```

---

## 🎯 Productivity Tools Setup (Script 8)

### Raycast Configuration

#### 1. Initial Setup
1. Open **Raycast** from Applications
2. Grant permissions:
   - Accessibility (required)
   - Screen Recording (optional)
   - Calendar access (optional)

#### 2. Set Hotkey
1. **System Preferences** → **Keyboard** → **Shortcuts** → **Spotlight**
2. Uncheck "Show Spotlight search" 
3. In Raycast: **Preferences** → **General**
4. Click hotkey field and press `⌘ Space`

#### 3. Essential Extensions
Open Raycast Store (`⌘ Space`, then search "store"):

**Must-Have Extensions:**
- **GitHub** - Search repos, issues, PRs
- **Homebrew** - Search and install packages
- **Kill Process** - Quickly kill frozen apps
- **System** - Empty trash, sleep, restart
- **Clipboard History** - Enhanced clipboard

**Developer Extensions:**
- **VSCode Recent Projects** - Quick project switching
- **npm Search** - Search npm packages
- **Can I Use** - Browser compatibility check
- **Lorem Ipsum** - Generate placeholder text
- **Color Picker** - Pick and convert colors
- **UUID Generator** - Generate UUIDs

#### 4. Configure Extensions
**GitHub Extension:**
1. Open extension settings
2. Generate Personal Access Token at GitHub
3. Add repositories to quick access

### Rectangle Window Management

#### 1. Launch and Permissions
1. Open **Rectangle** from Applications
2. Grant Accessibility permissions when prompted
3. Choose "Start Rectangle on login"

#### 2. Essential Shortcuts
Configure in Rectangle Preferences:
- Left Half: `⌘ ⌥ ←`
- Right Half: `⌘ ⌥ →`
- Top Half: `⌘ ⌥ ↑`
- Bottom Half: `⌘ ⌥ ↓`
- Maximize: `⌘ ⌥ F`
- Center: `⌘ ⌥ C`
- Restore: `⌘ ⌥ Backspace`

#### 3. Advanced Settings
- Enable "Move cursor between displays"
- Set gap between windows (if desired)
- Configure multiple display behavior

### 1Password Setup

#### 1. Account Setup
1. Open **1Password**
2. Choose setup option:
   - Sign in to existing account
   - Create new account at [1password.com](https://1password.com)
3. Save Emergency Kit PDF securely

#### 2. Browser Extensions
1. In 1Password: **Preferences** → **Browser**
2. Install for your browsers:
   - Chrome: [Chrome Web Store](https://chrome.google.com/webstore/detail/1password/aeblfdkhhhdcdjpifhhbdiojplfjncoa)
   - Firefox: [Firefox Add-ons](https://addons.mozilla.org/en-US/firefox/addon/1password-x-password-manager/)
   - Safari: Enable in Safari Extensions preferences

#### 3. Developer Features
**SSH Key Management:**
1. **Developer** → **SSH Agent** → Turn on
2. Add SSH keys to 1Password
3. Configure `~/.ssh/config`:
```bash
Host *
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
```

**CLI Tool:**
```bash
# Install 1Password CLI
brew install --cask 1password-cli

# Sign in
op signin
```

### Maccy Clipboard Manager

#### 1. Initial Setup
1. Open **Maccy** from Applications
2. Grant Accessibility permissions
3. Set preferences:
   - Hotkey: `⌘ Shift V` (recommended)
   - History size: 200 items
   - Launch at login: Enable

#### 2. Configuration
- Enable "Remove formatting"
- Set "Ignore" apps (like password managers)
- Configure appearance (light/dark)
- Pin frequently used items

---

## 🗄️ Database Tools Setup (Script 9)

### PostgreSQL Configuration

#### 1. Verify Installation
```bash
# Check PostgreSQL is running
brew services list | grep postgresql

# If not running, start it:
brew services start postgresql@15

# Check you can connect
psql postgres
# Type \q to quit
```

#### 2. Create Development User (Optional)
```bash
# Create a superuser for development
createuser -s dev_user

# Create a development database
createdb dev_db -O dev_user
```

#### 3. Configure PostgreSQL (Optional)
```bash
# Edit configuration if needed
code /opt/homebrew/var/postgresql@15/postgresql.conf

# Common settings:
# listen_addresses = 'localhost'
# port = 5432
# max_connections = 100
```

### Sequel Ace Setup

#### 1. First Connection
1. Open **Sequel Ace**
2. Create new connection:
   - **Name**: Local PostgreSQL
   - **Host**: 127.0.0.1
   - **Username**: Your Mac username or `dev_user`
   - **Password**: Leave blank (for local)
   - **Database**: postgres or dev_db
   - **Port**: 5432

#### 2. Save Favorites
1. Click "Add to Favorites"
2. Organize connections in folders
3. Set up SSH tunnels for remote databases

### Supabase CLI Setup

#### 1. Create Supabase Account
1. Visit [supabase.com](https://supabase.com)
2. Sign up with GitHub or email
3. Create your first project (for reference)

#### 2. Login Locally
```bash
# Login to Supabase
supabase login

# This opens browser for authentication
# Generates access token automatically
```

#### 3. Initialize Local Project
```bash
# In your project directory
supabase init

# Start local development stack
supabase start

# This starts:
# - PostgreSQL (port 54322)
# - Auth server (port 54321)
# - Storage API
# - Realtime server
# - Edge Functions

# Stop when done
supabase stop
```

#### 4. Link to Remote Project
```bash
# Link to existing Supabase project
supabase link --project-ref your-project-ref

# Pull remote schema
supabase db pull

# Push local changes
supabase db push
```

---

## ☁️ DevOps Tools Configuration (Script 10)

### AWS CLI Setup

#### 1. Create AWS Account
1. Visit [aws.amazon.com](https://aws.amazon.com)
2. Create account (requires credit card)
3. Set up IAM user for CLI access:
   - AWS Console → IAM → Users → Add User
   - Enable "Programmatic access"
   - Attach policies (e.g., AdministratorAccess for dev)
   - Save Access Key ID and Secret

#### 2. Configure AWS CLI
```bash
# Run configuration
aws configure

# Enter your credentials:
AWS Access Key ID [None]: YOUR_ACCESS_KEY
AWS Secret Access Key [None]: YOUR_SECRET_KEY
Default region name [None]: us-east-1
Default output format [None]: json

# For multiple profiles:
aws configure --profile dev
aws configure --profile prod
```

#### 3. Verify Configuration
```bash
# Test connection
aws sts get-caller-identity

# List S3 buckets (if any)
aws s3 ls

# Use specific profile
aws s3 ls --profile dev
```

### Kubernetes Setup

#### 1. kubectl Configuration
```bash
# If you have a cluster, get credentials:
# For EKS:
aws eks update-kubeconfig --name your-cluster --region us-east-1

# For other providers, follow their docs
# Verify connection
kubectl cluster-info
kubectl get nodes
```

#### 2. Kubernetes Context Management
```bash
# List all contexts
kubectx

# Switch context
kubectx production

# List namespaces
kubens

# Switch namespace
kubens backend

# Create aliases for common operations
echo 'alias k=kubectl' >> ~/.zshrc
echo 'alias kgp="kubectl get pods"' >> ~/.zshrc
echo 'alias kgs="kubectl get services"' >> ~/.zshrc
source ~/.zshrc
```

### OrbStack Configuration

#### 1. Initial Setup
1. Open **OrbStack** from Applications
2. Complete setup wizard
3. Choose resources allocation

#### 2. Docker Compatibility
```bash
# Verify Docker commands work
docker --version
docker ps

# Test with hello-world
docker run hello-world

# Docker Compose should also work
docker-compose --version
```

#### 3. Kubernetes in OrbStack (Optional)
1. OrbStack Settings → Kubernetes → Enable
2. Wait for cluster to start
3. Use `kubectl` with local cluster

### ngrok Setup

#### 1. Create Account
1. Visit [ngrok.com](https://ngrok.com)
2. Sign up for free account
3. Get your auth token from dashboard

#### 2. Authenticate
```bash
# Add your authtoken
ngrok config add-authtoken YOUR_AUTH_TOKEN

# Verify configuration
cat ~/.ngrok2/ngrok.yml
```

#### 3. Basic Usage
```bash
# Expose local port 3000
ngrok http 3000

# Custom subdomain (paid feature)
ngrok http -subdomain=myapp 3000

# Expose with basic auth
ngrok http -auth="user:password" 3000
```

---

## 🔤 Font Configuration (Script 11)

### VS Code Font Setup
1. Open VS Code Settings (`⌘,`)
2. Search for "font family"
3. Set to: `'Fira Code', 'JetBrains Mono', Menlo, Monaco`
4. Search for "font ligatures"
5. Enable font ligatures

### iTerm2 Font Setup
1. iTerm2 → Preferences → Profiles → Text
2. Click "Change Font"
3. Select "Fira Code" or "JetBrains Mono"
4. Enable ligatures if available
5. Adjust size (13-14pt recommended)

### Other Applications
**Android Studio:**
- Preferences → Editor → Font
- Choose JetBrains Mono (included by default)

**Cursor:**
- Settings → Editor → Font Family
- Set to Fira Code or JetBrains Mono

---

## 🔍 Verification Checklist

Run these commands to verify everything is configured:

```bash
# Version managers
node --version && npm --version
python --version && pip --version

# Git and GitHub
git config --get user.name
gh auth status

# Development tools
code --version
docker --version

# Cloud tools (if configured)
aws sts get-caller-identity
kubectl version --client

# Database
psql --version
supabase --version

# Mobile development
echo $ANDROID_HOME
echo $JAVA_HOME
```

---

## 🚨 Common Issues & Solutions

### Terminal/Shell Issues

**"command not found" after installation:**
```bash
# Solution: Reload shell configuration
source ~/.zshrc
# Or restart terminal completely
```

**PowerLevel10k icons not showing:**
- Install recommended Nerd Fonts during p10k configure
- Or manually: `p10k configure` and select compatible options

### Development Tools Issues

**VS Code `code` command not working:**
```bash
# Add to PATH manually
echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**GitHub CLI authentication failed:**
- Make sure you're copying the full code
- Try `gh auth logout` then `gh auth login` again
- Check firewall/proxy settings

### Mobile Development Issues

**ANDROID_HOME not set:**
```bash
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
source ~/.zshrc
```

**React Native doctor shows errors:**
- Run each fix command it suggests
- Restart terminal after fixes
- Make sure Xcode is fully installed and opened once

### Database Issues

**PostgreSQL not starting:**
```bash
# Check logs
brew services info postgresql@15
tail -f /opt/homebrew/var/log/postgresql@15.log

# Restart service
brew services restart postgresql@15
```

---

## 📚 Next Steps

### Learning Resources

**Official Documentation:**
- [VS Code Docs](https://code.visualstudio.com/docs)
- [React Native Docs](https://reactnative.dev/docs/environment-setup)
- [PostgreSQL Tutorial](https://www.postgresql.org/docs/current/tutorial.html)
- [Kubernetes Basics](https://kubernetes.io/docs/tutorials/kubernetes-basics/)

**Interactive Tutorials:**
- `vimtutor` - Learn Vim basics
- `tldr` - Simplified man pages (`npm install -g tldr`)
- Raycast tutorials (in app)

### Recommended First Projects

**Frontend Developer:**
```bash
npm create vite@latest my-first-vite-app
cd my-first-vite-app
npm install
npm run dev
```

**Mobile Developer:**
```bash
npx create-expo-app my-first-app
cd my-first-app
npx expo start
```

**Full Stack Developer:**
```bash
# Create Supabase + Next.js app
npx create-next-app@latest my-fullstack-app
cd my-fullstack-app
supabase init
supabase start
```

---

## 🎉 You're All Set!

Your Mac is now a powerful development machine. Remember:

1. **Take time to learn your tools** - Each one can significantly improve your workflow
2. **Customize as needed** - These are starting points, make them yours
3. **Keep tools updated** - Run `brew upgrade` periodically
4. **Join communities** - Many tools have active Discord/Slack communities
5. **Practice shortcuts** - Muscle memory makes you faster

**Happy coding! 🚀**

---

**Need help?** Check the [GitHub repository](https://github.com/allanasp/Setup-Developer-Mac) for updates and to report issues.