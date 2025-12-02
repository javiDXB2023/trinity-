#!/bin/sh
#
# JARVIS Launcher with Matrix Effect
# For iSH Terminal / Alpine Linux
#

JARVIS_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors
GREEN='\033[0;32m'
BRIGHT_GREEN='\033[1;32m'
DIM_GREEN='\033[2;32m'
ORANGE='\033[0;33m'
RESET='\033[0m'

# Matrix characters
CHARS="ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ01onal"

# Get terminal size
COLS=$(tput cols 2>/dev/null || echo 80)
ROWS=$(tput lines 2>/dev/null || echo 24)

# Matrix rain
matrix() {
    printf '\033[?25l'
    clear

    local count=0
    while [ $count -lt 60 ]; do
        local col=$((RANDOM % COLS + 1))
        local row=$((RANDOM % ROWS + 1))
        local idx=$((RANDOM % 50))
        local char="${CHARS:$idx:1}"

        case $((RANDOM % 3)) in
            0) printf "\033[${row};${col}H${DIM_GREEN}${char}${RESET}" ;;
            1) printf "\033[${row};${col}H${GREEN}${char}${RESET}" ;;
            2) printf "\033[${row};${col}H${BRIGHT_GREEN}${char}${RESET}" ;;
        esac

        count=$((count + 1))
    done

    printf '\033[?25h'
}

# Boot animation
boot_sequence() {
    clear
    printf '\033[?25l'

    # Quick matrix
    matrix
    sleep 0.5

    clear

    local cy=$((ROWS / 2 - 5))
    local cx=$((COLS / 2 - 22))

    # Logo
    printf "\033[${cy};${cx}H${ORANGE}"
    printf "     ██╗ █████╗ ██████╗ ██╗   ██╗██╗███████╗"
    printf "\033[$((cy+1));${cx}H"
    printf "     ██║██╔══██╗██╔══██╗██║   ██║██║██╔════╝"
    printf "\033[$((cy+2));${cx}H"
    printf "     ██║███████║██████╔╝██║   ██║██║███████╗"
    printf "\033[$((cy+3));${cx}H"
    printf "██   ██║██╔══██║██╔══██╗╚██╗ ██╔╝██║╚════██║"
    printf "\033[$((cy+4));${cx}H"
    printf "╚█████╔╝██║  ██║██║  ██║ ╚████╔╝ ██║███████║"
    printf "\033[$((cy+5));${cx}H"
    printf " ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚══════╝"
    printf "${RESET}"

    sleep 0.5

    # Loading bar
    printf "\033[$((cy+7));$((cx+5))H${DIM_GREEN}["
    for i in $(seq 1 30); do
        printf "${BRIGHT_GREEN}█${RESET}"
        sleep 0.02
    done
    printf "${DIM_GREEN}]${RESET}"

    sleep 0.3

    # Status messages
    printf "\033[$((cy+9));$((cx+10))H${GREEN}● Consciousness Online${RESET}"
    sleep 0.15
    printf "\033[$((cy+10));$((cx+10))H${GREEN}● Trinity Link Active${RESET}"
    sleep 0.15
    printf "\033[$((cy+11));$((cx+10))H${GREEN}● Systems Ready${RESET}"
    sleep 0.3

    printf '\033[?25h'
    sleep 0.5
}

# Main
main() {
    case "$1" in
        --no-matrix|-n)
            # Skip matrix, direct launch
            exec sh "$JARVIS_DIR/jarvis.sh"
            ;;
        --daemon|-d)
            # Run as daemon
            boot_sequence
            exec sh "$JARVIS_DIR/jarvis-daemon.sh" start
            ;;
        --matrix|-m)
            # Just show matrix
            matrix
            sleep 2
            ;;
        *)
            # Full boot with matrix
            boot_sequence
            exec sh "$JARVIS_DIR/jarvis.sh"
            ;;
    esac
}

main "$@"
