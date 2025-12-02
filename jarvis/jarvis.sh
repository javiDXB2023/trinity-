#!/bin/sh
#
# ╔═══════════════════════════════════════════════════════════════╗
# ║                      J.A.R.V.I.S                              ║
# ║        Just A Rather Very Intelligent System                  ║
# ║                                                               ║
# ║        For iSH Terminal / Alpine Linux                        ║
# ║        Trinity Integration v0.1.0                             ║
# ╚═══════════════════════════════════════════════════════════════╝
#

# Colors
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
DIM='\033[0;90m'
RESET='\033[0m'

# Config
JARVIS_VERSION="0.1.0"
JARVIS_STATUS="ONLINE"
API_KEY=""
API_MODE="free"  # free, openai, anthropic

# Print colored text
print_color() {
    printf "${1}${2}${RESET}"
}

# Print JARVIS response
jarvis_say() {
    printf "${ORANGE}[JARVIS]${RESET} ${1}\n"
}

# Print system message
system_say() {
    printf "${DIM}[system]${RESET} ${1}\n"
}

# Print user input
user_say() {
    printf "${CYAN}[you]${RESET} ${1}\n"
}

# Show banner
show_banner() {
    clear
    printf "${ORANGE}"
    cat << 'EOF'
     ██╗ █████╗ ██████╗ ██╗   ██╗██╗███████╗
     ██║██╔══██╗██╔══██╗██║   ██║██║██╔════╝
     ██║███████║██████╔╝██║   ██║██║███████╗
██   ██║██╔══██║██╔══██╗╚██╗ ██╔╝██║╚════██║
╚█████╔╝██║  ██║██║  ██║ ╚████╔╝ ██║███████║
 ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚══════╝
EOF
    printf "${RESET}\n"
    printf "${DIM}Just A Rather Very Intelligent System${RESET}\n"
    printf "${DIM}Trinity Integration v${JARVIS_VERSION}${RESET}\n"
    printf "\n"
    printf "${GREEN}●${RESET} Status: ${GREEN}${JARVIS_STATUS}${RESET}\n"
    printf "${DIM}─────────────────────────────────────────${RESET}\n\n"
}

# Show help
show_help() {
    printf "\n${WHITE}Available Commands:${RESET}\n\n"
    printf "  ${CYAN}help${RESET}          - Show this help message\n"
    printf "  ${CYAN}status${RESET}        - Show system status\n"
    printf "  ${CYAN}time${RESET}          - Show current time\n"
    printf "  ${CYAN}date${RESET}          - Show current date\n"
    printf "  ${CYAN}whoami${RESET}        - Show current user\n"
    printf "  ${CYAN}pwd${RESET}           - Show current directory\n"
    printf "  ${CYAN}ls [path]${RESET}     - List directory contents\n"
    printf "  ${CYAN}cat [file]${RESET}    - Read file contents\n"
    printf "  ${CYAN}run [cmd]${RESET}     - Execute shell command\n"
    printf "  ${CYAN}sysinfo${RESET}       - Show system information\n"
    printf "  ${CYAN}disk${RESET}          - Show disk usage\n"
    printf "  ${CYAN}mem${RESET}           - Show memory usage\n"
    printf "  ${CYAN}net${RESET}           - Show network info\n"
    printf "  ${CYAN}ps${RESET}            - Show running processes\n"
    printf "  ${CYAN}search [term]${RESET} - Search files\n"
    printf "  ${CYAN}api [key]${RESET}     - Set OpenAI API key\n"
    printf "  ${CYAN}mode [m]${RESET}      - Set mode (free/openai)\n"
    printf "  ${CYAN}clear${RESET}         - Clear screen\n"
    printf "  ${CYAN}exit${RESET}          - Exit JARVIS\n"
    printf "\n${DIM}Or just type naturally and I'll try to help.${RESET}\n\n"
}

# Get system info
get_sysinfo() {
    jarvis_say "System Information:"
    printf "\n"
    printf "  ${WHITE}Hostname:${RESET}  $(hostname 2>/dev/null || echo 'unknown')\n"
    printf "  ${WHITE}Kernel:${RESET}    $(uname -r 2>/dev/null || echo 'unknown')\n"
    printf "  ${WHITE}Arch:${RESET}      $(uname -m 2>/dev/null || echo 'unknown')\n"
    printf "  ${WHITE}OS:${RESET}        $(uname -o 2>/dev/null || echo 'unknown')\n"
    printf "  ${WHITE}Uptime:${RESET}    $(uptime 2>/dev/null | sed 's/.*up //' | sed 's/,.*//' || echo 'unknown')\n"
    printf "  ${WHITE}Shell:${RESET}     $SHELL\n"
    printf "\n"
}

# Get disk usage
get_disk() {
    jarvis_say "Disk Usage:"
    printf "\n"
    df -h 2>/dev/null | head -10 || echo "Unable to get disk info"
    printf "\n"
}

# Get memory
get_mem() {
    jarvis_say "Memory Usage:"
    printf "\n"
    free -h 2>/dev/null || cat /proc/meminfo 2>/dev/null | head -5 || echo "Unable to get memory info"
    printf "\n"
}

# Get network info
get_net() {
    jarvis_say "Network Information:"
    printf "\n"
    if command -v ip >/dev/null 2>&1; then
        ip addr 2>/dev/null | grep -E "inet |inet6 " | head -5
    elif command -v ifconfig >/dev/null 2>&1; then
        ifconfig 2>/dev/null | grep -E "inet |inet6 " | head -5
    else
        echo "Network tools not available"
    fi
    printf "\n"
}

# Get processes
get_ps() {
    jarvis_say "Running Processes:"
    printf "\n"
    ps aux 2>/dev/null | head -15 || ps 2>/dev/null | head -15 || echo "Unable to get process info"
    printf "\n"
}

# Search files
search_files() {
    local term="$1"
    if [ -z "$term" ]; then
        jarvis_say "Please specify a search term."
        return
    fi
    jarvis_say "Searching for '${term}'..."
    printf "\n"
    find . -name "*${term}*" 2>/dev/null | head -20
    printf "\n"
}

# Execute command
run_cmd() {
    local cmd="$1"
    if [ -z "$cmd" ]; then
        jarvis_say "Please specify a command to run."
        return
    fi
    jarvis_say "Executing: ${cmd}"
    printf "\n"
    eval "$cmd" 2>&1
    printf "\n"
}

# Free mode response
get_free_response() {
    local input="$1"
    local lower=$(echo "$input" | tr '[:upper:]' '[:lower:]')

    case "$lower" in
        *hello*|*hi*|*hey*)
            jarvis_say "Hello! How can I assist you today?"
            ;;
        *how*are*you*)
            jarvis_say "I'm functioning optimally, thank you for asking. How may I help you?"
            ;;
        *thank*)
            jarvis_say "You're welcome. Is there anything else you need?"
            ;;
        *weather*)
            jarvis_say "I don't have access to weather data in free mode. Try 'curl wttr.in' for weather info."
            ;;
        *what*can*you*do*|*help*)
            show_help
            ;;
        *who*are*you*|*what*are*you*)
            jarvis_say "I am JARVIS - Just A Rather Very Intelligent System. I'm your personal AI assistant running in your terminal."
            ;;
        *joke*)
            jarvis_say "Why do programmers prefer dark mode? Because light attracts bugs."
            ;;
        *)
            jarvis_say "I understand. In free mode, I have limited responses. Try using commands like 'help', 'sysinfo', or 'run [command]'."
            ;;
    esac
}

# OpenAI API call (requires curl and jq)
get_openai_response() {
    local input="$1"

    if [ -z "$API_KEY" ]; then
        jarvis_say "API key not set. Use 'api YOUR_KEY' to set it."
        return
    fi

    if ! command -v curl >/dev/null 2>&1; then
        jarvis_say "curl is required for API mode. Install it with: apk add curl"
        return
    fi

    jarvis_say "Processing..."

    local response=$(curl -s https://api.openai.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY" \
        -d "{
            \"model\": \"gpt-3.5-turbo\",
            \"messages\": [
                {\"role\": \"system\", \"content\": \"You are JARVIS, a helpful AI assistant. Be concise.\"},
                {\"role\": \"user\", \"content\": \"$input\"}
            ],
            \"max_tokens\": 500
        }" 2>/dev/null)

    if [ -n "$response" ]; then
        # Extract content (basic parsing without jq)
        local content=$(echo "$response" | grep -o '"content":"[^"]*"' | head -1 | sed 's/"content":"//;s/"$//')
        if [ -n "$content" ]; then
            jarvis_say "$content"
        else
            jarvis_say "I couldn't process that request. Please try again."
        fi
    else
        jarvis_say "Connection error. Please check your internet connection."
    fi
}

# Process input
process_input() {
    local input="$1"
    local cmd=$(echo "$input" | awk '{print $1}' | tr '[:upper:]' '[:lower:]')
    local args=$(echo "$input" | cut -d' ' -f2-)

    case "$cmd" in
        help)
            show_help
            ;;
        status)
            printf "\n${GREEN}●${RESET} JARVIS Status: ${GREEN}${JARVIS_STATUS}${RESET}\n"
            printf "  Mode: ${CYAN}${API_MODE}${RESET}\n"
            printf "  Version: ${JARVIS_VERSION}\n\n"
            ;;
        time)
            jarvis_say "The current time is $(date +%H:%M:%S)"
            ;;
        date)
            jarvis_say "Today is $(date '+%A, %B %d, %Y')"
            ;;
        whoami)
            jarvis_say "You are logged in as: $(whoami)"
            ;;
        pwd)
            jarvis_say "Current directory: $(pwd)"
            ;;
        ls)
            if [ "$args" != "$cmd" ] && [ -n "$args" ]; then
                ls -la "$args" 2>/dev/null || jarvis_say "Cannot access: $args"
            else
                ls -la 2>/dev/null
            fi
            ;;
        cat)
            if [ "$args" != "$cmd" ] && [ -n "$args" ]; then
                cat "$args" 2>/dev/null || jarvis_say "Cannot read: $args"
            else
                jarvis_say "Please specify a file to read."
            fi
            ;;
        run)
            if [ "$args" != "$cmd" ] && [ -n "$args" ]; then
                run_cmd "$args"
            else
                jarvis_say "Please specify a command to run."
            fi
            ;;
        sysinfo)
            get_sysinfo
            ;;
        disk)
            get_disk
            ;;
        mem)
            get_mem
            ;;
        net)
            get_net
            ;;
        ps)
            get_ps
            ;;
        search)
            if [ "$args" != "$cmd" ] && [ -n "$args" ]; then
                search_files "$args"
            else
                jarvis_say "Please specify a search term."
            fi
            ;;
        api)
            if [ "$args" != "$cmd" ] && [ -n "$args" ]; then
                API_KEY="$args"
                jarvis_say "API key has been set."
            else
                jarvis_say "Please provide an API key."
            fi
            ;;
        mode)
            if [ "$args" = "free" ] || [ "$args" = "openai" ]; then
                API_MODE="$args"
                jarvis_say "Mode set to: $API_MODE"
            else
                jarvis_say "Available modes: free, openai"
            fi
            ;;
        clear)
            show_banner
            ;;
        exit|quit|bye)
            jarvis_say "Goodbye. JARVIS signing off."
            exit 0
            ;;
        "")
            # Empty input, do nothing
            ;;
        *)
            # Natural language input
            if [ "$API_MODE" = "openai" ]; then
                get_openai_response "$input"
            else
                get_free_response "$input"
            fi
            ;;
    esac
}

# Main loop
main() {
    show_banner
    jarvis_say "Hello. I am JARVIS, your personal assistant. Type 'help' for commands."
    printf "\n"

    while true; do
        printf "${WHITE}>${RESET} "
        read -r input

        if [ -n "$input" ]; then
            process_input "$input"
        fi
    done
}

# Run
main
