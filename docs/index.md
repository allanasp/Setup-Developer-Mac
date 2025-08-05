---
layout: default
title: Mac Developer Setup
description: Complete modular Mac development environment setup scripts
---

# 🚀 Mac Frontend Developer Setup

> **🎨 Modular setup scripts tailored for frontend developers** - React, Vue, React Native, and the complete JavaScript/TypeScript ecosystem

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-Compatible-brightgreen.svg)](https://www.apple.com/macos/)
[![Shell Script](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)

Choose exactly what you need - from essential system requirements to frontend-specific development tools. **Optimized for JavaScript/TypeScript developers** working with React, Vue, Angular, React Native, and modern web technologies. No bloat, no unnecessary installations.

## ⚡ Quick Start

```bash
# Clone the repository
git clone https://github.com/allanasp/Setup-Developer-Mac.git
cd Setup-Developer-Mac

# Interactive setup (recommended)
./setup.sh
```

**🎯 Interactive Experience:**
- ✅ Install → ⚙️ Configure → ✅ Verify → Continue
- Each tool gets properly set up before moving to the next
- No more guessing what to do after installation!

**Example selections:**
- Type `5 6 9` → Frontend Tools + Dev Apps + Database Tools
- Type `all` → Install everything  
- Press Enter → Just essentials

---

## 📦 Available Scripts

### 🔧 Essential Scripts (Auto-Installed)
<div class="script-grid">
  <div class="script-card essential">
    <h4>1. System Requirements</h4>
    <p>Xcode CLI Tools, Homebrew, basic system configuration</p>
    <code>./scripts/01-system.sh</code>
  </div>
  
  <div class="script-card essential">
    <h4>2. Terminal & Shell</h4>
    <p>iTerm2, Oh My Zsh, PowerLevel10k, Dracula theme</p>
    <code>./scripts/02-terminal.sh</code>
  </div>
  
  <div class="script-card essential">
    <h4>3. Version Managers</h4>
    <p>Volta (Node.js), pyenv (Python), latest versions</p>
    <code>./scripts/03-version-managers.sh</code>
  </div>
</div>

### 📦 Optional Scripts (Choose What You Need)
<div class="script-grid">
  <div class="script-card optional">
    <h4>4. Programming Languages</h4>
    <p>Java JDK, Go, Ruby for backend development</p>
    <code>./scripts/04-languages.sh</code>
  </div>
  
  <div class="script-card optional frontend-highlight">
    <h4>5. Frontend Tools ⭐ CORE</h4>
    <p>TypeScript, Vue, React Native, Vite, Storyblok, Sanity - The heart of this setup!</p>
    <code>./scripts/05-frontend.sh</code>
  </div>
  
  <div class="script-card optional">
    <h4>6. Development Apps</h4>
    <p>VS Code + 20+ extensions, Cursor, Git tools</p>
    <code>./scripts/06-dev-apps.sh</code>
  </div>
  
  <div class="script-card optional">
    <h4>7. Mobile Development</h4>
    <p>Android Studio, iOS tools, CocoaPods, React Native</p>
    <code>./scripts/07-mobile.sh</code>
  </div>
  
  <div class="script-card optional">
    <h4>8. Productivity Tools</h4>
    <p>Raycast, Rectangle, 1Password, Maccy clipboard</p>
    <code>./scripts/08-productivity.sh</code>
  </div>
  
  <div class="script-card optional">
    <h4>9. Database Tools</h4>
    <p>PostgreSQL, Sequel Ace, Supabase CLI</p>
    <code>./scripts/09-database.sh</code>
  </div>
  
  <div class="script-card optional">
    <h4>10. DevOps Tools</h4>
    <p>Kubernetes, AWS CLI, OrbStack, ngrok</p>
    <code>./scripts/10-devops.sh</code>
  </div>
  
  <div class="script-card optional">
    <h4>11. Developer Fonts</h4>
    <p>Fira Code, JetBrains Mono, programming fonts</p>
    <code>./scripts/11-fonts.sh</code>
  </div>
</div>

---

## 🎯 Usage Examples

### 🎨 Frontend Developer (React/Vue)
```bash
./setup.sh
# Choose: 5 6 8 11
# Gets: Frontend Tools + Dev Apps + Productivity + Fonts
# Perfect for: React, Vue, Angular, TypeScript development
```

### 📱 React Native Developer  
```bash
./setup.sh
# Choose: 5 6 7 8 11
# Gets: Frontend + Dev Apps + Mobile + Productivity + Fonts
# Perfect for: Cross-platform mobile app development
```

### 🚀 Fullstack JavaScript Developer
```bash
./setup.sh
# Choose: 4 5 6 8 9
# Gets: Languages + Frontend + Dev Apps + Productivity + Database
# Perfect for: MERN/MEAN stack, Node.js backends
```

### 🏢 Enterprise Frontend Developer
```bash
./setup.sh
# Choose: 4 5 6 8 9 10
# Gets: Languages + Frontend + Dev Apps + Productivity + Database + DevOps
# Perfect for: Large-scale applications with deployment needs
```

---

## 🔧 What Makes This Frontend-Focused

- **🎨 Frontend-First** - Prioritizes JavaScript/TypeScript ecosystem
- **🎯 Modular** - Install only what you need for your stack
- **⚡ Fast** - Essential Node.js/npm tools install first automatically  
- **🔄 Maintainable** - Update individual components as frameworks evolve
- **📖 Well Documented** - Every script explained with frontend use cases
- **🛡️ Safe** - Scripts can be re-run safely as projects change
- **🤝 Community Driven** - Built by frontend developers, for frontend developers

---

## 📋 Post-Installation

### Essential First Steps
1. **Restart terminal** or `source ~/.zshrc`
2. **Configure PowerLevel10k**: `p10k configure` 
3. **Import Dracula theme**: iTerm2 → Preferences → Colors
4. **Verify setup**: `./check-setup.sh` - shows what's working ✅

### Tool Configuration
- Set up Git identity and GitHub authentication
- Configure VS Code settings and extensions
- Initialize cloud accounts (AWS, Supabase)
- Set up productivity apps (Raycast, Rectangle)

**[📋 Complete Post-Installation Guide →](post-installation.html)**

---

## 📚 Documentation

- **[🛠️ Complete Tools Guide](tools-guide.html)** - Detailed info on all 100+ tools installed
- **[📖 Script Documentation](script-guide.html)** - How each script works
- **[🔍 Setup Checker](setup-checker.html)** - Verify your installation works
- **[🔧 Troubleshooting](script-guide.html#troubleshooting)** - Common issues and solutions  
- **[⚙️ Customization](script-guide.html#customization)** - Add your own tools

---

## 🚀 Get Started

<div class="cta-section">
  <a href="https://github.com/allanasp/Setup-Developer-Mac" class="cta-button primary">
    📥 Clone Repository
  </a>
  
  <a href="script-guide.html" class="cta-button secondary">
    📖 Read Full Guide
  </a>
</div>

```bash
git clone https://github.com/allanasp/Setup-Developer-Mac.git
cd Setup-Developer-Mac
./setup.sh
```

---

<div class="footer">
  <p><strong>Made with ❤️ for the developer community</strong></p>
  <p>
    <a href="https://github.com/allanasp/Setup-Developer-Mac">GitHub</a> •
    <a href="script-guide.html">Full Documentation</a> •
    <a href="https://github.com/allanasp/Setup-Developer-Mac/issues">Report Issues</a>
  </p>
</div>

<style>
.script-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1rem;
  margin: 1rem 0;
}

.script-card {
  border: 1px solid #e1e4e8;
  border-radius: 8px;
  padding: 1rem;
  background: #f6f8fa;
}

.script-card.essential {
  border-color: #28a745;
  background: #f0fff4;
}

.script-card.optional {
  border-color: #0366d6;
  background: #f1f8ff;
}

.script-card.frontend-highlight {
  border-color: #ff6b35;
  background: #fff5f2;
  border-width: 2px;
}

.script-card h4 {
  margin: 0 0 0.5rem 0;
  color: #24292e;
}

.script-card p {
  margin: 0 0 0.5rem 0;
  color: #586069;
  font-size: 0.9em;
}

.script-card code {
  background: #27303a;
  color: #fff;
  padding: 0.2rem 0.4rem;
  border-radius: 4px;
  font-size: 0.8em;
}

.cta-section {
  text-align: center;
  margin: 2rem 0;
}

.cta-button {
  display: inline-block;
  padding: 12px 24px;
  margin: 0 8px;
  border-radius: 6px;
  text-decoration: none;
  font-weight: bold;
  transition: all 0.2s;
}

.cta-button.primary {
  background: #28a745;
  color: white;
}

.cta-button.secondary {
  background: #0366d6;
  color: white;
}

.cta-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.footer {
  text-align: center;
  margin-top: 3rem;
  padding: 2rem 0;
  border-top: 1px solid #e1e4e8;
  color: #586069;
}

.footer a {
  color: #0366d6;
  text-decoration: none;
}

.footer a:hover {
  text-decoration: underline;
}
</style>