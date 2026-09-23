#!/usr/bin/env bash
# ============================================================
#  SycoTool - Setup Script (Linux)
#  Works on: Kali Linux / NetHunter / Debian / Ubuntu
#  ✔ ASCII-only output (works on Termux & minimal terminals)
#  ✔ pip-style progress bar for extraction
#  ✔ Auto-launches core/sycotool when done
# ============================================================

set -e

# ---------- Colors ----------
G="\033[92m"; Y="\033[93m"; R="\033[91m"; C="\033[96m"; W="\033[97m"; B="\033[1m"; N="\033[0m"
M="\033[95m"

ok()   { echo -e "${G}[+]${N} $1"; }
info() { echo -e "${C}[?]${N} $1"; }
skip() { echo -e "${Y}[=]${N} $1"; }
warn() { echo -e "${Y}[!]${N} $1"; }
err()  { echo -e "${R}[-]${N} $1"; }

# ---------- Developer Info ----------
DEV_NAME="Issam Junior"
DEV_TELEGRAM="@issamiso"
DEV_URL="https://t.me/issamiso"
CHANNEL_NAME="mylinuxlife"
CHANNEL_URL="https://t.me/mylinuxlife"

print_dev_banner() {
    echo ""
    echo -e "${C}============================================================${N}"
    echo -e "${C}   ${B}SycoTool${N} ${W}- Developer Info${N}"
    echo -e "${C}============================================================${N}"
    echo -e "   ${G}${B}Developer${N} : ${W}${DEV_NAME}${N}"
    echo -e "   ${G}${B}Telegram ${N} : ${C}${DEV_TELEGRAM}${N}  ${W}(${DEV_URL})${N}"
    echo -e "   ${G}${B}Channel  ${N} : ${C}${CHANNEL_NAME}${N}  ${W}(${CHANNEL_URL})${N}"
    echo -e "${C}============================================================${N}"
    echo ""
}

# ---------- Local install prefix (no root needed) ----------
LOCAL_BIN="$HOME/.local/bin"
LOCAL_OPT="$HOME/.local/opt"
mkdir -p "$LOCAL_BIN" "$LOCAL_OPT"
export PATH="$LOCAL_BIN:$PATH"

# ---------- Detect distro ----------
DISTRO=""
[ -f /etc/os-release ] && . /etc/os-release && DISTRO="$ID"
info "Detected distro: ${DISTRO:-unknown}"

# ---------- Passwordless sudo? ----------
HAS_SUDO=0
if command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
    HAS_SUDO=1
    info "Passwordless sudo available."
else
    info "No passwordless sudo - will install user-local where possible."
fi

# ============================================================
# HELPER : is a command present?
# ============================================================
has() { command -v "$1" >/dev/null 2>&1; }

# ============================================================
# PIP-STYLE PROGRESS BAR EXTRACTION
# ============================================================
extract_with_progress() {
    local archive="$1"
    local dest="$2"

    local total
    total=$(tar -tvJf "$archive" 2>/dev/null | awk '{s+=$3} END {printf "%d", s+0}')
    [ "$total" -le 0 ] && total=1

    local initial
    initial=$(du -sb "$dest" 2>/dev/null | awk '{printf "%d", $1}')
    [ -z "$initial" ] && initial=0

    tar -xJf "$archive" -C "$dest" 2>/dev/null &
    local pid=$!

    local width=25
    local start
    start=$(date +%s)

    while kill -0 "$pid" 2>/dev/null; do
        local cur
        cur=$(du -sb "$dest" 2>/dev/null | awk '{printf "%d", $1}')
        [ -z "$cur" ] && cur=0

        local extracted=$((cur - initial))
        [ "$extracted" -lt 0 ] && extracted=0

        local pct=$((extracted * 100 / total))
        [ "$pct" -gt 99 ] && pct=99
        [ "$pct" -lt 0 ]  && pct=0

        local fill=$((pct * width / 100))
        local empty=$((width - fill))

        local now
        now=$(date +%s)
        local elapsed=$((now - start))
        [ "$elapsed" -lt 1 ] && elapsed=1

        local speed=$((extracted / elapsed))
        local speed_mb=$((speed / 1024 / 1024))

        local eta=0
        if [ "$speed" -gt 0 ]; then
            eta=$(( (total - extracted) / speed ))
        fi

        local bar_fill bar_empty
        bar_fill=$(printf "%${fill}s"  | tr ' ' '=')
        bar_empty=$(printf "%${empty}s" | tr ' ' ' ')

        printf "\r${C}[?]${N} Extracting  [${G}%s${N}%s] %3d%%  %3d MB/s  ETA %02ds " \
            "$bar_fill" "$bar_empty" "$pct" "$speed_mb" "$eta"

        sleep 0.15
    done

    wait "$pid"
    local rc=$?

    if [ "$rc" -eq 0 ]; then
        local full_bar
        full_bar=$(printf "%${width}s" | tr ' ' '=')
        printf "\r${C}[+]${N} Extracting  [${G}%s${N}] 100%%                              \n" \
            "$full_bar"
    else
        printf "\r${R}[-]${N} Extracting failed - archive may be corrupted.              \n"
    fi

    return "$rc"
}

# ============================================================
# 1) JAVA
# ============================================================
install_java() {
    if has java; then
        local ver
        ver=$(java -version 2>&1 | head -n1)
        skip "Java already installed -> $ver"
        return
    fi

    info "Java not found - installing JDK 17..."
    if [ "$HAS_SUDO" -eq 1 ]; then
        sudo apt-get update -y
        sudo apt-get install -y openjdk-17-jdk-headless
    else
        err "No sudo - cannot install Java automatically."
        err "Please run:  sudo apt install openjdk-17-jdk-headless"
        exit 1
    fi
    ok "Java 17 installed."
}

# ============================================================
# 2) BASIC UTILS
# ============================================================
install_basic_utils() {
    local missing=()
    for t in wget unzip tar xz; do
        if ! has "$t"; then
            missing+=("$t")
        else
            skip "$t already installed"
        fi
    done

    if [ ${#missing[@]} -eq 0 ]; then
        ok "Required utilities present."
        return
    fi

    info "Missing utilities: ${missing[*]}"
    if [ "$HAS_SUDO" -eq 1 ]; then
        sudo apt-get update -y
        sudo apt-get install -y "${missing[@]}"
        ok "Basic utilities installed."
    else
        err "Cannot install ${missing[*]} without sudo."
        exit 1
    fi
}

# ============================================================
# 3) APKTOOL
# ============================================================
install_apktool() {
    if has apktool; then
        skip "apktool already installed -> $(command -v apktool)"
        return
    fi

    if [ "$HAS_SUDO" -eq 1 ]; then
        info "Trying: apt install apktool ..."
        if sudo apt-get install -y apktool 2>/dev/null; then
            if has apktool; then
                ok "apktool installed via apt."
                return
            fi
        fi
        warn "apt has no apktool package - falling back to manual download."
    fi

    info "Downloading apktool (manual)..."
    local APKTOOL_VERSION="2.9.3"
    local JAR="$LOCAL_BIN/apktool.jar"
    local BIN="$LOCAL_BIN/apktool"

    if ! wget -q --show-progress -O "$JAR" \
        "https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_${APKTOOL_VERSION}.jar"; then
        err "Failed to download apktool.jar"
        exit 1
    fi

    cat > "$BIN" <<EOF
#!/usr/bin/env bash
exec java -jar "$JAR" "\$@"
EOF
    chmod +x "$BIN"

    ok "apktool installed -> $BIN"
}

# ============================================================
# 4) ZIPALIGN + APKSIGNER
# ============================================================
install_build_tools() {
    local need_zip=0 need_sign=0
    has zipalign  || need_zip=1
    has apksigner || need_sign=1

    if [ "$need_zip" -eq 0 ] && [ "$need_sign" -eq 0 ]; then
        skip "zipalign + apksigner already installed"
        return
    fi

    [ "$need_zip"  -eq 0 ] && skip "zipalign already installed"
    [ "$need_sign" -eq 0 ] && skip "apksigner already installed"

    if [ "$HAS_SUDO" -eq 1 ]; then
        info "Trying: apt install zipalign apksigner ..."
        local pkgs=()
        [ "$need_zip"  -eq 1 ] && pkgs+=("zipalign")
        [ "$need_sign" -eq 1 ] && pkgs+=("apksigner")

        if sudo apt-get install -y "${pkgs[@]}" 2>/dev/null; then
            if has zipalign && has apksigner; then
                ok "zipalign + apksigner installed via apt."
                return
            fi
        fi
        warn "apt does not provide them - falling back to Android SDK."
    fi

    info "Downloading Android build-tools into $LOCAL_OPT/android-sdk ..."
    local SDK_ROOT="$LOCAL_OPT/android-sdk"
    local BT_VERSION="34.0.0"
    local BT_DIR="$SDK_ROOT/build-tools/$BT_VERSION"

    if [ ! -x "$BT_DIR/zipalign" ]; then
        mkdir -p "$SDK_ROOT/cmdline-tools"
        pushd "$SDK_ROOT/cmdline-tools" >/dev/null

        wget -q --show-progress -O cmdline-tools.zip \
            https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip

        unzip -q -o cmdline-tools.zip
        rm -f cmdline-tools.zip

        rm -rf latest
        mv cmdline-tools latest 2>/dev/null || true

        local SDKMANAGER="$SDK_ROOT/cmdline-tools/latest/bin/sdkmanager"
        chmod +x "$SDKMANAGER"

        info "Accepting Android SDK licenses..."
        yes | "$SDKMANAGER" --sdk_root="$SDK_ROOT" --licenses >/dev/null 2>&1 || true

        info "Installing build-tools;$BT_VERSION ..."
        "$SDKMANAGER" --sdk_root="$SDK_ROOT" "build-tools;$BT_VERSION" >/dev/null

        popd >/dev/null
    fi

    [ "$need_zip"  -eq 1 ] && ln -sf "$BT_DIR/zipalign"  "$LOCAL_BIN/zipalign"
    [ "$need_sign" -eq 1 ] && ln -sf "$BT_DIR/apksigner" "$LOCAL_BIN/apksigner"

    ok "zipalign + apksigner linked into $LOCAL_BIN"
}

# ============================================================
# 5) PERSIST PATH
# ============================================================
persist_path() {
    local RC="$HOME/.bashrc"
    [ -n "$ZSH_VERSION" ] && RC="$HOME/.zshrc"

    local MARKER="# >>> SycoTool env >>>"
    if ! grep -q "$MARKER" "$RC" 2>/dev/null; then
        {
            echo ""
            echo "$MARKER"
            echo 'export PATH="$HOME/.local/bin:$PATH"'
            echo 'export ANDROID_SDK_ROOT="$HOME/.local/opt/android-sdk"'
            echo 'export ANDROID_HOME="$HOME/.local/opt/android-sdk"'
            echo "# <<< SycoTool env <<<"
        } >> "$RC"
        ok "PATH added to $RC"
        warn "Reload shell:  source $RC"
    else
        skip "PATH already configured in $RC"
    fi
}

# ============================================================
# 6) VERIFY
# ============================================================
verify() {
    echo ""
    info "Verifying installations..."
    echo ""

    check() {
        if has "$1"; then
            printf "  ${G}[+]${N} %-12s ${W}%s${N}\n" "$1" "$(command -v "$1")"
        else
            printf "  ${R}[-]${N} %-12s ${R}NOT FOUND${N}\n" "$1"
        fi
    }

    check java
    check apktool
    check zipalign
    check apksigner
    echo ""
}

# ============================================================
# MAIN
# ============================================================
main() {
    echo ""
    echo -e "${G}${B}============================================================${N}"
    echo -e "${G}${B}   SycoTool - Setup (Linux)${N}"
    echo -e "${G}${B}============================================================${N}"

    print_dev_banner

    install_java
    install_basic_utils
    install_apktool
    install_build_tools
    persist_path
    verify

    echo -e "${G}[+]${N} Setup complete!"
    echo ""

    # ---------- Locate the tool ----------
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    TOOL_DIR="$SCRIPT_DIR/core"
    TOOL_BIN="$TOOL_DIR/sycotool"
    ARCHIVE="$TOOL_DIR/bin.tar.xz"

    if [ ! -d "$TOOL_DIR" ]; then
        err "Directory not found: $TOOL_DIR"
        exit 1
    fi

    # ---------- First run: extract with progress + dev info ----------
    if [ ! -f "$TOOL_BIN" ]; then
        if [ ! -f "$ARCHIVE" ]; then
            err "Neither 'sycotool' nor 'bin.tar.xz' found in: $TOOL_DIR"
            exit 1
        fi

        echo -e "${C}============================================================${N}"
        echo -e "   ${B}First-time setup${N} - extracting payload"
        echo -e "${C}============================================================${N}"
        echo -e "   ${G}Developer${N} : ${W}${DEV_NAME}${N}"
        echo -e "   ${G}Telegram ${N} : ${C}${DEV_TELEGRAM}${N}"
        echo -e "   ${G}Channel  ${N} : ${C}${CHANNEL_URL}${N}"
        echo -e "${C}============================================================${N}"
        echo ""

        if ! extract_with_progress "$ARCHIVE" "$TOOL_DIR"; then
            err "Extraction failed."
            exit 1
        fi

        chmod +x "$TOOL_BIN" 2>/dev/null || true

        rm -f "$ARCHIVE"
        ok "Compressed archive deleted."

        echo ""
        echo -e "${C}------------------------------------------------------------${N}"
        echo -e "   ${G}${B}Thanks for using SycoTool${N}"
        echo -e "   ${C}${DEV_TELEGRAM}${N}   |   ${C}${CHANNEL_URL}${N}"
        echo -e "${C}------------------------------------------------------------${N}"
        echo ""

    else
        skip "Binary already extracted -> $TOOL_BIN"
    fi

    # ---------- Sanity check ----------
    if [ ! -f "$TOOL_BIN" ]; then
        err "Compiled tool not found: $TOOL_BIN"
        exit 1
    fi

    if [ ! -x "$TOOL_BIN" ]; then
        warn "sycotool is not executable - fixing permissions..."
        chmod +x "$TOOL_BIN"
    fi

    echo ""
    info "Launching SycoTool from $TOOL_DIR ..."
    echo ""

    export PATH="$HOME/.local/bin:$PATH"
    export ANDROID_SDK_ROOT="$HOME/.local/opt/android-sdk"
    export ANDROID_HOME="$HOME/.local/opt/android-sdk"
    export SYCOTOOL_NO_CLEAR=1

    cd "$TOOL_DIR"
    exec ./sycotool
}

main "$@"
