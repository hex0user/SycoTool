<div align="center">

# 🛠️ SycoTool

### APK Modding & Penetration Testing Framework

[![Version](https://img.shields.io/badge/version-v1.0-blue.svg)](https://github.com/hex0user/SycoTool)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Kali%20%7C%20NetHunter-orange.svg)](https://kali.org)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Telegram](https://img.shields.io/badge/Telegram-@issamiso-2CA5E0?logo=telegram)](https://t.me/issamiso)
[![Channel](https://img.shields.io/badge/Channel-mylinuxlife-2CA5E0?logo=telegram)](https://t.me/mylinuxlife)
[![GitHub](https://img.shields.io/badge/GitHub-hex0user-181717?logo=github)](https://github.com/hex0user)

**A powerful, all-in-one APK modding framework for authorized penetration testing.**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Contact](#-contact)

</div>

---

## ⚠️ Disclaimer

> **SycoTool is provided for educational and authorized penetration testing purposes only.**
>
> The developer (**Issam Junior — @issamiso**) disclaims all responsibility and liability
> for any misuse, illegal activity, or damage caused by this tool.
> **You are solely responsible for how you use it.**
>
> Using this tool against systems you do not own or lack explicit permission
> to test is **illegal** and may result in criminal prosecution.

---

## ✨ Features

- 🎯 **Interactive CLI** — clean, colorful terminal UI with animations
- 🔐 **APK Rebuild Pipeline** — apktool → zipalign → apksigner
- 📝 **App Name Modification** — updates both manifest and resources
- 🖼️ **Custom Icon Support** — auto-resizes for all Android densities (hdpi → xxxhdpi)
- 🔗 **Redirect URL Injection** — modify smali values directly
- ⚙️ **Upload Service Patching** — inject credentials into smali
- 📜 **Built-in History** — auto-saves and lists every generated payload
- 📦 **Self-Extracting** — compressed distribution with auto-decompression
- 🚀 **One-Command Setup** — auto-detects and installs missing dependencies

---

## 📋 Requirements

| Tool | Purpose | Auto-Installed |
|------|---------|:--------------:|
| **Java (JDK 17+)** | Required by apktool | ✅ |
| **apktool** | Decompile / rebuild APKs | ✅ |
| **zipalign** | Align APK boundaries | ✅ |
| **apksigner** | Sign APKs with keystore | ✅ |
| **wget / unzip / tar / xz** | Downloads & extraction | ✅ |

**Supported platforms:**
- ✅ Kali Linux
- ✅ Kali NetHunter
- ✅ Debian / Ubuntu
- ✅ Any Debian-based distro

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
2. Check every dependency (only installs what's missing)
3. Extract the tool automatically
4. Launch it for you

---

## 🎮 Usage

### Launch

```bash
./sycotool.sh        # recommended — handles setup + launch
```

or, if already extracted:

```bash
cd core && ./sycotool
```

### Main Menu

```
============================================================
   SycoTool - MAIN MENU
============================================================
   [1]  Create New Payload
   [2]  Show History
   [3]  Contact Me
   [0]  Exit
============================================================
```

### Creating a Payload

The interactive workflow asks for:

| Step | Prompt | Notes |
|------|--------|-------|
| 1 | **App name** | Leave empty to keep default |
| 2 | **Redirect URL** | URL opened after photos are sent |
| 3 | **Telegram User ID** | Your personal chat ID |
| 4 | **Telegram Bot Token** | Token from @BotFather |
| 5 | **Icon path** | PNG/JPG/WEBP — auto-resized |

### Viewing History

Menu option [2] lists every previously generated payload with:

- Project name
- Creation timestamp
- Option to copy to any destination path

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| xz: command not found | sudo apt install xz-utils |
| apktool: command not found | sudo apt install apktool |
| Extraction fails | Check disk space: df -h ~ |
| Permission denied | chmod +x core/sycotool |
| Screen clears unexpectedly | Ensure SYCOTOOL_NO_CLEAR=1 is exported |

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

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

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## ⭐ Show Your Support

If SycoTool helped you, please give it a ⭐ on GitHub!

<div align="center">

**Made with ❤️ by [Issam Junior (@hex0user)](https://github.com/hex0user)**

</div>
