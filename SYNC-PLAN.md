# Setup-repo → nuværende maskine: synkroniseringsplan

> **Formål:** Bringe hele setup-projektet (scripts + docs + check-setup) i overensstemmelse med Allans nuværende maskine (brew + Volta + pyenv), inkl. skift fra Yarn til bun/pnpm.
>
> **Sådan bruger du filen:** Rediger frit. Beslutningspunkter er markeret med `🟦 BESLUTNING:` — udfyld/ret dem. Tjeklister med `[ ]` = ikke besluttet, `[x]` = ja/medtag. Når du er færdig, siger du til, og jeg udfører planen.

---

## 0. Bekræftede beslutninger (allerede aftalt)

- [x] **Yarn fjernes** → erstattes af **bun + pnpm**.
- [x] **WireGuard beholdes** (installeret via App Store, ikke brew — derfor ikke i `brew list`).
- [x] **Terminal-tema:** PowerLevel10k-prompt + Dracula-farveskema (ensret ordlyd i docs).

---

## 1. Åbne overordnede beslutninger

### 🟦 BESLUTNING D1 — Sync-retning
Vælg én (sæt `x`):
- [ ] **Spejl** (tilføj alt du kører + fjern det du ikke bruger)
- [ ] **Additiv + skift defaults** (tilføj dine værktøjer, behold curated alternativer som valgfrie)
- [ ] **Kun tilføj** (tilføj manglende, fjern intet udover yarn)

> Note: "fjern"-listen i §3 kan ikke stoles 100% på, da den kun er udledt fra `brew list` — App Store/manuelle installs (som WireGuard) dukker ikke op der. Bekræft hver enkelt.

### 🟦 BESLUTNING D2 — `@grundtone/*` private pakker
4 Volta-globals: `@grundtone/core`, `@grundtone/design-system`, `@grundtone/nuxt`, `@grundtone/vue`.
- [ ] Ekskludér (anbefalet hvis repo er delbart)
- [ ] Inkludér

> Åbent spørgsmål: Kan `@grundtone/*` overhovedet installeres uden privat npm-login/registry? _____________

### 🟦 BESLUTNING D3 — Repo-natur
- [ ] Delbart/offentligt "frontend dev setup" (hold privat/personligt ude)
- [ ] Rent personligt maskine-snapshot (alt må med)

### 🟦 BESLUTNING D4 — "Nuværende setup" betydning
- [ ] Præcis det installerede nu
- [ ] Den ideelle setup fremad (fx kun nyeste Node/npm-defaults, ikke alle 16 Node- / 7 npm-versioner)

---

## 2. Tilføjes (du kører dem, scripts installerer dem IKKE i dag)

### CLI / formulae
| Værktøj | Foreslået script | Medtag? |
|---|---|---|
| pnpm (Volta) | 03-version-managers | [x] (bekræftet) |
| bun (Volta) | 03-version-managers | [x] (bekræftet) |
| helm | 10-devops | [ ] |
| kops | 10-devops | [ ] |
| kubectx | 10-devops | [ ] |
| tilt | 10-devops | [ ] |
| doctl (DigitalOcean) | 10-devops | [ ] |
| upcloud-cli (tap) | 10-devops | [ ] |
| ollama | 10-devops | [ ] |
| neovim | 06-dev-apps / 10 | [ ] |
| vim | 06-dev-apps / 10 | [ ] |
| mkcert | 10-devops | [ ] |
| composer (PHP) | 04-languages | [ ] |
| imagemagick | 10-devops / util | [ ] |
| poppler | 10-devops / util | [ ] |
| openjdk (latest, udover @17) | 04-languages | [ ] |

### Volta-globals
| Pakke | Foreslået script | Medtag? |
|---|---|---|
| vercel | 05-frontend | [ ] |
| @sentry/cli | 05-frontend | [ ] |
| nativescript | 05-frontend | [ ] |
| local-ssl-proxy | 05-frontend | [ ] |
| @grundtone/* (×4) | 05-frontend | se D2 |

### Apps / casks
| App | Foreslået script | Medtag? |
|---|---|---|
| gcloud-cli | 10-devops | [ ] |
| amazon-q (AI) | 06-dev-apps | [ ] |
| kiro-cli (AI editor) | 06-dev-apps | [ ] |
| devtoys | 06-dev-apps | [ ] |
| sequel-ace (DB GUI) | 09-database | [ ] |
| mockoon (API mock) | 09-database / dev | [ ] |
| localsend | 08-productivity | [ ] |
| zulu (JDK) | 04-languages | [ ] |
| font-hack-nerd-font | 11-fonts | [ ] |
| font-source-code-pro | 11-fonts | [ ] |

### Andet (installeres IKKE via brew)
| Værktøj | Metode | Foreslået script | Medtag? |
|---|---|---|---|
| Maestro (mobil UI-test; `maestro studio` er en subkommando, ikke separat install) | `curl -Ls get.maestro.mobile.dev \| bash` → `~/.maestro` (kræver Java) | 07-mobile | [ ] |

### Allerede installeret af scripts (forbliver — ingen ændring nødvendig)
> Disse kører du allerede, OG scripts installerer dem i forvejen — derfor er de bevidst IKKE i "Tilføjes"-listerne ovenfor.
- **Expo/mobil (05-frontend.sh):** `@expo/cli`, `eas-cli`, `create-expo-app`, `@react-native-community/cli`
- **Frontend (05-frontend.sh):** `@vue/cli`, `nuxt`, `typescript`, `create-vite`, `serve`, `storyblok`, `@sanity/cli`, `watchman`
- **Øvrige:** git, gh, git-flow-avh, go, openjdk@17, postgresql@15, supabase, awscli, eza, wget, jq, tree, fzf, cocoapods, ios-deploy, xcodes, swiftlint + apps (VS Code, Zed, TextMate, GitHub Desktop, Android Studio, Raycast, Maccy, Obsidian, OrbStack, Postman, Figma, ImageOptim, AppCleaner, Ice, 1Password CLI, Warp, fonts)

> **upcloud-cli** er allerede med i §2 (CLI/formulae → 10-devops) som `upcloudltd/tap/upcloud-cli`.

---

## 2b. Claude Code MCP-servere (NY i repo'et)

### 🟦 BESLUTNING D5 — Skal MCP-opsætning automatiseres?
- [ ] Ja — nyt script (fx `12-claude-mcp.sh`) der kører `claude mcp add --transport http <navn> <url>` for hver server
- [ ] Nej — hold MCP ude af repo'et

> De fleste kræver OAuth bagefter (`/mcp` i Claude Code) — selve auth kan ikke automatiseres, men registreringen kan. Følger repo'ets "TODO for manuelle trin"-mønster.

Konfigurerede servere nu (23 stk):
- **Tilslutter uden ekstra auth:** Clerk, Mermaid Chart (×2), Vercel, NUXT UI, NUXT 4, Hugging Face, Sanity
- **Kræver OAuth (`/mcp` bagefter):** Supabase, Ahrefs, PostHog, Expo, Gmail, Google Drive, Google Calendar, Atlassian, Netlify, Plaid, Sentry
- **Plugin-leverede (følger med plugin — tilføj IKKE manuelt):** `plugin:vercel`, `plugin:expo`, `posthog`

> 🟦 Vælg hvilke der skal med i scriptet — fx kun udvikler-relevante (Supabase, Vercel, Netlify, Sentry, Expo, Sanity, NUXT, Clerk, PostHog) og udelad personlige (Gmail, Google Drive/Calendar, Plaid, Ahrefs)?

---

## 3. Fjern-kandidater (scripts installerer, men ikke i din `brew list`)
> Bekræft individuelt — kan være App Store/manuelt installeret.

| Værktøj | Script | Beslutning |
|---|---|---|
| Cursor | 06 | [ ] behold / [ ] fjern |
| Ruby (brew) | 04 | [ ] behold / [ ] fjern |

---

## 4. Rettelser (navne-drift / fejl — uafhængigt af D1-D4)

| Fil | Nuværende | Rettes til | OK? |
|---|---|---|---|
| 06-dev-apps.sh | `sst/tap/opencode` | `anomalyco/tap/opencode` | [ ] |
| 08-productivity.sh | cask `syncthing` | `syncthing-app` | [ ] |
| 08-productivity.sh | cask `wireshark` | `wireshark-app` | [ ] |
| 03-version-managers.sh | installerer `yarn` | fjern + `volta install pnpm bun` | [x] |

---

## 5. Dokumentation der skal opdateres

| Fil | Ændring | OK? |
|---|---|---|
| README.md | Yarn → bun + pnpm (linje 30, 165) | [x] |
| README.md | Fjern hængende code-fence (linje 92) | [x] |
| README.md | `setup-modular.sh` → `setup.sh` (linje 365) | [x] |
| README.md | Ensret værktøjstal (80+/100+) | [ ] |
| README.md | Tema-ordlyd: P10k + Dracula | [x] |
| README.md | Opdater værktøjslister til ny stak | [ ] |
| START_HERE.md | `npm/yarn` → `npm/pnpm/bun` (linje 24) | [x] |
| check-setup.sh | Fjern Yarn-check, tilføj bun-check | [x] |
| check-setup.sh | Tilføj checks for nye værktøjer | [ ] |
| SCRIPT_GUIDE.md | Gennemgå for Yarn/værktøjsdrift | [ ] |
| POST-INSTALLATION-GUIDE.md | Gennemgå for Yarn/værktøjsdrift | [ ] |
| docs/ | Gennemgå website-indhold | [ ] |

---

## 6. Punkter jeg skal verificere før udførelse
- [ ] Hvad `11-fonts.sh` præcist installerer (font-liste).
- [ ] Om `ngrok`/`gcloud` skal være formula eller cask (du har dem som cask).
- [ ] Node-default: scripts bruger `node@lts`, din default er `node@24.13.0` — pin eller behold lts?
- [ ] Skal pyenv stadig sætte 3.9.6 / 3.10.13 / 3.12.1? (matcher i dag) + evt. brew `python@3.11`.

---

## 7. Udførelsesrækkefølge (når beslutninger er sat)
1. `03-version-managers.sh` — yarn ud, bun+pnpm ind.
2. Rettelser §4 (navne-drift).
3. Tilføjelser §2 pr. script (kun de afkrydsede).
4. Fjernelser §3 (kun de afkrydsede).
5. `check-setup.sh` opdateres til at matche.
6. Docs §5.
7. Syntakstjek alle scripts (`bash -n`) + idempotens-gennemgang.
