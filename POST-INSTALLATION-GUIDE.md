# 📋 Post-Installation Setup Guide

> **Complete this guide after running `./setup.sh` to activate and configure all installed tools**

This guide walks you through the essential post-installation steps to get your development environment fully operational. Follow these steps in order for the best experience.

## 🔄 Step 1: Restart Terminal & Activate Environment

### Restart Terminal
```bash
# Close all terminal windows and reopen, OR run:
source ~/.zshrc
```

### Verify Core Tools Are Active
```bash
# Check that version managers are working
volta --version    # Should show Volta version
pyenv --version    # Should show pyenv version
node --version     # Should show Node.js version
python --version   # Should show Python version
code --version     # Should show VS Code version
```

If any command fails, restart your terminal completely.

---

## 🎨 Step 2: Configure PowerLevel10k Theme

PowerLevel10k provides a beautiful, informative terminal prompt.

```bash
# Run the configuration wizard
p10k configure
```

**Configuration Tips:**
- Choose "Yes" to install Meslo Nerd Font when prompted
- Select your preferred prompt style (recommended: lean or classic)
- Enable transient prompt for cleaner history
- Choose your preferred icons and colors

---

## 🖥️ Step 3: Configure iTerm2

### Set iTerm2 as Default Terminal
1. Open **System Preferences** → **General** → **Default web browser**
2. Change terminal to **iTerm2**

### Verify Black Background
1. Open iTerm2
2. Go to **Preferences** (⌘+,)
3. Navigate to **Profiles** → **Colors**
4. Verify background is black - if not, select "Black" preset

### Optional: Import Better Color Scheme
```bash
# Download popular Dracula theme (optional)
git clone https://github.com/dracula/iterm.git /tmp/dracula-iterm
```
Then import `/tmp/dracula-iterm/Dracula.itermcolors` in iTerm2 Preferences.

---

## 🚀 Step 4: Configure Raycast (Spotlight Replacement)

### Initial Setup
1. Open **Raycast** from Applications
2. **Grant permissions** when prompted (Accessibility, Screen Recording)
3. **Set CMD+Space shortcut**:
   - Open **System Preferences** → **Keyboard** → **Shortcuts** → **Spotlight**
   - **Uncheck** "Show Spotlight search"
   - In Raycast: **Preferences** → **General** → Set hotkey to **CMD+Space**

### Essential Raycast Extensions
Open Raycast (⌘+Space) and search for "Store":

```
# Install these extensions:
- Homebrew (manage packages)
- GitHub (search repos, issues)
- Figma Files (quick access)
- System Preferences (quick settings)
- Window Management (backup for Rectangle)
- Color Picker (design tool)
- UUID Generator (development utility)
```

### Configure Raycast Aliases
In Raycast Preferences → Extensions, set up aliases:
- `gh` → GitHub extension
- `brew` → Homebrew extension
- `fig` → Figma Files

---

## 🔐 Step 5: Setup GitHub Authentication

### GitHub CLI Authentication
```bash
# Authenticate with GitHub
gh auth login

# Follow prompts:
# 1. Choose "GitHub.com"
# 2. Choose "HTTPS" 
# 3. Choose "Login with a web browser"
# 4. Copy the one-time code and open browser
```

### Verify GitHub Setup
```bash
# Test GitHub CLI
gh repo list
gh auth status

# Configure Git if not already done
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

---

## ☁️ Step 6: Configure AWS CLI & Amazon Q

### AWS CLI Configuration
```bash
# Configure AWS credentials
aws configure

# Enter your:
# - AWS Access Key ID
# - AWS Secret Access Key  
# - Default region (e.g., us-east-1)
# - Default output format (json)
```

### Amazon Q in VS Code
1. Open **VS Code**
2. **AWS Toolkit extension** should be installed
3. Click **AWS icon** in sidebar
4. Click **Add Connection** → **Use IAM Credentials**
5. **Sign in** with your AWS account
6. **Amazon Q** will be available in the Command Palette (⌘+Shift+P)

### Verify Amazon Q
```bash
# Test AWS CLI connection
aws sts get-caller-identity

# In VS Code: ⌘+Shift+P → "Amazon Q: Start Chat"
```

---

## 🤖 Step 7: Activate Claude Code

### Verify Claude Installation
```bash
# Check if Claude is installed
claude --version

# If not found, install via Volta
volta install @anthropic-ai/claude-code
```

### Claude Setup
```bash
# Initialize Claude (follow authentication prompts)
claude auth login

# Test Claude
claude --help
```

### Use Claude in Terminal
```bash
# Start a conversation with Claude
claude

# Or ask direct questions
claude "How do I optimize React performance?"
```

---

## 🪟 Step 8: Configure Rectangle Window Management

### Setup Rectangle
1. Open **Rectangle** from Applications
2. **Grant Accessibility permissions** when prompted
3. **Configure shortcuts** (recommended):
   - Left Half: `⌘+⌥+←`
   - Right Half: `⌘+⌥+→`
   - Top Half: `⌘+⌥+↑`
   - Bottom Half: `⌘+⌥+↓`
   - Maximize: `⌘+⌥+F`
   - Center: `⌘+⌥+C`

### Test Window Management
- Try `⌘+⌥+←` to snap current window to left half
- Try `⌘+⌥+F` to maximize current window

---

## 📋 Step 9: Configure Maccy Clipboard Manager

### Setup Maccy
1. Open **Maccy** from Applications
2. **Grant Accessibility permissions**
3. **Set global shortcut**: Recommended `⌘+Shift+V`
4. **Configure history size**: 100+ items
5. **Enable launch at login**

### Test Clipboard Manager
1. Copy several different items
2. Press `⌘+Shift+V` to see clipboard history
3. Select an item to paste it

---

## 🔑 Step 10: Configure 1Password

### 1Password Setup
1. Open **1Password** from Applications
2. **Sign in** to your 1Password account
3. **Install browser extensions**:
   - Chrome: Install from Chrome Web Store
   - Firefox: Install from Firefox Add-ons
   - Safari: Enable in Safari Extensions preferences

### SSH Key Management (Optional)
```bash
# Configure 1Password for SSH key management
# Follow: https://developer.1password.com/docs/ssh/get-started
```

---

## 📱 Step 11: Mobile Development Setup

### Android Studio Configuration (React Native)
1. Open **Android Studio**
2. **Complete initial setup wizard**
3. **Install required Android SDK components**:
   - Android SDK API 35 (latest)
   - Android SDK Platform-Tools
   - Android SDK Build-Tools
   - Android SDK Command-line Tools
4. **Accept Android licenses**:
   ```bash
   yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses
   ```
5. **Create Android Virtual Device (AVD)**:
   - Tools → AVD Manager → Create Virtual Device
   - Choose Pixel device and latest Android version
6. **Verify environment**:
   ```bash
   echo $ANDROID_HOME  # Should show Android SDK path
   echo $JAVA_HOME     # Should show Java 17 path
   java --version      # Should show Java 17
   ```

### iOS Development
1. **Install Xcode** from App Store (large download ~15GB)
2. **Re-run the setup script** to complete iOS configuration:
   ```bash
   ./setup.sh
   # Choose "y" for iOS development tools
   # Script will automatically accept Xcode license and install SwiftLint
   ```
3. **Or manually complete setup**:
   ```bash
   sudo xcodebuild -license accept
   brew install swiftlint
   ```
4. **Optional: Install specific Xcode versions**:
   ```bash
   xcodes install --latest
   ```

### React Native Environment Verification
```bash
# Check React Native environment setup
npx react-native doctor

# Verify tools are installed
react-native --version
expo --version
eas --version
watchman --version
```

### Create and Test React Native Projects
```bash
# Option 1: Create bare React Native project
npx react-native@latest init TestProject
cd TestProject

# Test Android (start AVD first in Android Studio)
npx react-native run-android

# Test iOS (requires Xcode + Simulator)
npx react-native run-ios

# Option 2: Create Expo project
npx create-expo-app TestExpoApp
cd TestExpoApp

# Start Expo development server
npx expo start
```

### EAS CLI Setup (Expo Application Services)
```bash
# Login to Expo account
eas login

# In an Expo project, configure EAS Build
cd your-expo-project
eas build:configure

# Create development build
eas build --platform android --profile development
eas build --platform ios --profile development

# Submit to app stores (when ready)
eas submit --platform android
eas submit --platform ios
```

---

## 🗄️ Step 12: Database Setup

### PostgreSQL Configuration
```bash
# Start PostgreSQL service
brew services start postgresql@15

# Create your first database
createdb my_dev_database

# Test connection
psql my_dev_database
# Type \q to quit
```

### Sequel Ace Setup
1. Open **Sequel Ace**
2. **Create new connection**:
   - Host: `localhost`
   - Username: `your_mac_username`
   - Password: (leave blank for local connection)
   - Database: `my_dev_database`
   - Port: `5432`

---

## ⚡ Step 13: Verify Development Tools

### Frontend Development
```bash
# Test Vue.js
vue create test-vue-project
cd test-vue-project && npm run serve

# Test React
npx create-react-app test-react-app
cd test-react-app && npm start

# Test Nuxt.js
npx nuxi@latest init test-nuxt-app
cd test-nuxt-app && npm run dev
```

### Python Development
```bash
# Set global Python version
pyenv global 3.12.1

# Create virtual environment
python -m venv test_env
source test_env/bin/activate
pip install requests flask
```

### Go Development
```bash
# Test Go installation
go version

# Create test Go project
mkdir test-go && cd test-go
go mod init test-go
echo 'package main\nimport "fmt"\nfunc main() { fmt.Println("Hello Go!") }' > main.go
go run main.go
```

---

## 🔧 Step 14: Optional Advanced Configurations

### Git Flow Setup
```bash
# Initialize Git Flow in your projects
cd your-project
git flow init
# Accept all defaults by pressing Enter
```

### Kubernetes Setup (If Needed)
```bash
# Configure kubectl context (requires cluster access)
kubectl config get-contexts

# Test Kubernetes tools
kubectx  # List contexts
kubens   # List namespaces
```

### VS Code Workspace Settings
Create `.vscode/settings.json` in your projects:
```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "python.defaultInterpreterPath": "python",
  "typescript.preferences.importModuleSpecifier": "relative"
}
```

---

## ✅ Step 15: Final Verification

Run the verification script to ensure everything is working:

```bash
./check-setup.sh
```

### Manual Tests
Test these key combinations:
- `⌘+Space` → Should open Raycast
- `⌘+⌥+←` → Should snap window left
- `⌘+Shift+V` → Should open clipboard history
- Open iTerm2 → Should have black background
- Type `node --version` → Should show Node.js version
- Type `python --version` → Should show Python 3.12.1

---

## 🚨 Troubleshooting

### Common Issues

**iTerm2 not using black theme:**
```bash
# Manually set iTerm2 preferences
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/Library/Application Support/iTerm2/DynamicProfiles"
```

**VS Code 'code' command not found:**
```bash
# Add VS Code to PATH
echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**pyenv Python versions not available:**
```bash
# Reinstall Python versions
pyenv install 3.12.1
pyenv global 3.12.1
```

**Raycast not working with CMD+Space:**
- Go to System Preferences → Keyboard → Shortcuts → Spotlight
- Disable Spotlight shortcuts first

**AWS CLI/Amazon Q not working:**
```bash
# Verify AWS configuration
aws configure list
aws sts get-caller-identity
```

---

## 🎉 You're All Set!

Your Mac development environment is now fully configured! You have:

- ✅ Modern terminal with PowerLevel10k theme
- ✅ AI coding assistants (Claude, Amazon Q, GitHub Copilot)
- ✅ Productivity tools (Raycast, Rectangle, Maccy)
- ✅ Complete development stack (Node.js, Python, Java, Go)
- ✅ Mobile development environment (iOS & Android)
- ✅ Database and DevOps tools
- ✅ Security and authentication setup

## 📚 Next Steps

1. **Explore VS Code extensions** - Install project-specific extensions as needed
2. **Customize your shell** - Add personal aliases to `~/.zshrc`
3. **Set up your first project** - Clone a repository and start coding!
4. **Join communities** - Connect with other developers using these tools

**Happy coding! 🚀**