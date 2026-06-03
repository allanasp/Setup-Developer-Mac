# 🚀 Start Here - Mac Frontend Developer Setup

## Quick Start (1 Line)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/allanasp/Setup-Developer-Mac/main/install.sh)"
```

Append `-- --skip-prompts` for a non-interactive run. Set the `SETUP_OPTIONAL` env var to pick which optional scripts to install.

---

## Quick Start (2 Steps)

### 1. Clone this repository
```bash
git clone https://github.com/allanasp/Setup-Developer-Mac.git
cd Setup-Developer-Mac
```

### 2. Run the main setup script
```bash
./setup.sh
```

**That's it!** The script will guide you through everything else.

---

## 🎯 What This Does

**Frontend-focused Mac development environment** with:
- ✅ **React, Vue, Angular** development tools
- ✅ **Node.js, TypeScript, pnpm/bun** ecosystem  
- ✅ **React Native & Expo** mobile development
- ✅ **VS Code, Cursor, Kiro** editors
- ✅ **Terminal** with beautiful themes
- ✅ **Git, databases, DevOps** tools as needed

## 🔄 Interactive Experience

The setup **guides you step-by-step**:
1. **Install** → Tools get installed
2. **Configure** → You set up each tool properly  
3. **Verify** → Confirm everything works
4. **Continue** → Move to next component

No guessing, no broken setups!

## 📋 What You'll Choose

**Essential (auto-installed):**
- System requirements (Xcode, Homebrew)
- Terminal & shell (iTerm2, Oh My Zsh)
- Version managers (Node.js, Python)

**Optional (pick what you need):**
- Frontend tools (TypeScript, Vue, React Native, Turbo, Vercel CLI)
- Development apps (VS Code, Cursor, Kiro)
- Mobile development (Android Studio, iOS tools)
- Productivity tools (Rectangle, Mockoon, Expo Orbit, DevToys, Signal, WiFiman)
- Database tools (PostgreSQL, Supabase, pgAdmin 4)
- DevOps tools (ngrok, UpCloud CLI, kubectl, Tilt, Terraform, utilities)
- Developer fonts (Fira Code, JetBrains Mono)
- Expo + React Native local dev (Watchman, OpenJDK 17, Android Studio, iOS toolchain, Maestro)

## 🆘 Need Help?

- 📖 **Full documentation**: [View website](https://allanasp.github.io/Setup-Developer-Mac)
- 🐛 **Found a bug?**: [Report issue](https://github.com/allanasp/Setup-Developer-Mac/issues)
- 💡 **Want a tool added?**: [Request tool](https://github.com/allanasp/Setup-Developer-Mac/issues/new/choose)

---

## ⚡ Advanced Usage

```bash
# Interactive mode (recommended)
./setup.sh

# Non-interactive mode (for automation)
./setup.sh --skip-prompts

# Check what's installed after setup
./check-setup.sh

# Run individual scripts
./scripts/05-frontend.sh        # Just frontend tools
./scripts/06-dev-apps.sh        # Just VS Code & extensions
./scripts/12-expo-rn.sh         # Just Expo + React Native local dev
```

## 🔍 Verify Your Setup

After installation, run the checker to see what's working:
```bash
./check-setup.sh
```

This will show you:
- ✅ What's installed and working
- ❌ What's missing or needs attention  
- 📊 Overall setup completion percentage
- 🔧 Specific version information for each tool

**Ready to get started?** Run `./setup.sh` now! 🚀