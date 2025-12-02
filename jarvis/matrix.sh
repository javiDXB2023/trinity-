#!/bin/sh
#
# Matrix Rain Effect for JARVIS startup
#

# Colors
GREEN='\033[0;32m'
BRIGHT_GREEN='\033[1;32m'
DIM_GREEN='\033[2;32m'
RESET='\033[0m'

# Matrix characters
CHARS="アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン0123456789JARVIS"

# Get terminal size
get_size() {
    COLS=$(tput cols 2>/dev/null || echo 80)
    ROWS=$(tput lines 2>/dev/null || echo 24)
}

# Generate random character
rand_char() {
    local len=${#CHARS}
    local idx=$((RANDOM % len))
    echo "${CHARS:$idx:1}"
}

# Matrix rain effect
matrix_rain() {
    local duration=${1:-3}
    local end_time=$(($(date +%s) + duration))

    # Hide cursor
    printf '\033[?25l'

    # Clear screen
    clear

    get_size

    while [ $(date +%s) -lt $end_time ]; do
        local col=$((RANDOM % COLS))
        local row=$((RANDOM % ROWS))
        local char=$(rand_char)

        # Random green shade
        local shade=$((RANDOM % 3))
        case $shade in
            0) printf "\033[${row};${col}H${DIM_GREEN}${char}${RESET}" ;;
            1) printf "\033[${row};${col}H${GREEN}${char}${RESET}" ;;
            2) printf "\033[${row};${col}H${BRIGHT_GREEN}${char}${RESET}" ;;
        esac

        # Small delay
        sleep 0.01 2>/dev/null || true
    done

    # Show cursor
    printf '\033[?25h'
    clear
}

# Simple matrix columns
matrix_columns() {
    local duration=${1:-3}

    printf '\033[?25l'
    clear

    get_size
    local cols_arr=""

    # Initialize column positions
    for i in $(seq 1 $COLS); do
        cols_arr="$cols_arr 0"
    done

    local count=0
    local max_count=$((duration * 30))

    while [ $count -lt $max_count ]; do
        for col in $(seq 1 $COLS); do
            if [ $((RANDOM % 20)) -eq 0 ]; then
                local row=$((RANDOM % ROWS + 1))
                local char=$(rand_char)
                printf "\033[${row};${col}H${GREEN}${char}${RESET}"
            fi
        done
        sleep 0.03 2>/dev/null || true
        count=$((count + 1))
    done

    printf '\033[?25h'
    clear
}

# Fancy JARVIS boot sequence
jarvis_boot() {
    clear
    printf '\033[?25l'

    get_size
    local center_row=$((ROWS / 2))
    local center_col=$((COLS / 2 - 20))

    # Matrix effect first
    matrix_columns 2

    # Show JARVIS logo with animation
    clear

    sleep 0.2

    printf "\033[${center_row};${center_col}H${GREEN}Initializing JARVIS...${RESET}"
    sleep 0.5

    printf "\033[$((center_row+1));${center_col}H${DIM_GREEN}[${RESET}"
    for i in $(seq 1 20); do
        printf "${BRIGHT_GREEN}█${RESET}"
        sleep 0.05
    done
    printf "${DIM_GREEN}]${RESET}"

    sleep 0.3

    printf "\033[$((center_row+2));${center_col}H${GREEN}● System Online${RESET}"
    sleep 0.2
    printf "\033[$((center_row+3));${center_col}H${GREEN}● Trinity Link Active${RESET}"
    sleep 0.2
    printf "\033[$((center_row+4));${center_col}H${GREEN}● Voice Systems Ready${RESET}"
    sleep 0.5

    printf '\033[?25h'
    sleep 0.5
}

# Run if called directly
if [ "$1" = "boot" ]; then
    jarvis_boot
elif [ "$1" = "rain" ]; then
    matrix_rain ${2:-5}
elif [ "$1" = "columns" ]; then
    matrix_columns ${2:-5}
else
    matrix_columns 2
fi
