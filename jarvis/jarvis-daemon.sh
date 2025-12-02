#!/bin/sh
#
# JARVIS Background Daemon
# Runs JARVIS as a background service
#

JARVIS_DIR="$(cd "$(dirname "$0")" && pwd)"
JARVIS_PID="/tmp/jarvis.pid"
JARVIS_LOG="/tmp/jarvis.log"
JARVIS_FIFO="/tmp/jarvis.fifo"

# Colors
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'

start_daemon() {
    if [ -f "$JARVIS_PID" ]; then
        local pid=$(cat "$JARVIS_PID")
        if kill -0 "$pid" 2>/dev/null; then
            echo "${ORANGE}[JARVIS]${RESET} Already running (PID: $pid)"
            return 1
        fi
    fi

    # Create FIFO for communication
    rm -f "$JARVIS_FIFO"
    mkfifo "$JARVIS_FIFO" 2>/dev/null

    # Start background process
    (
        while true; do
            if [ -p "$JARVIS_FIFO" ]; then
                while read -r cmd < "$JARVIS_FIFO"; do
                    echo "[$(date '+%H:%M:%S')] Command: $cmd" >> "$JARVIS_LOG"
                    # Process commands here
                    case "$cmd" in
                        stop)
                            echo "[$(date '+%H:%M:%S')] Stopping JARVIS" >> "$JARVIS_LOG"
                            exit 0
                            ;;
                        status)
                            echo "JARVIS is running" >> "$JARVIS_LOG"
                            ;;
                        *)
                            echo "[$(date '+%H:%M:%S')] Processing: $cmd" >> "$JARVIS_LOG"
                            ;;
                    esac
                done
            fi
            sleep 1
        done
    ) &

    echo $! > "$JARVIS_PID"
    echo "${GREEN}[JARVIS]${RESET} Started in background (PID: $(cat $JARVIS_PID))"
    echo "${GREEN}[JARVIS]${RESET} Log: $JARVIS_LOG"
}

stop_daemon() {
    if [ -f "$JARVIS_PID" ]; then
        local pid=$(cat "$JARVIS_PID")
        if kill -0 "$pid" 2>/dev/null; then
            echo "stop" > "$JARVIS_FIFO" 2>/dev/null
            kill "$pid" 2>/dev/null
            rm -f "$JARVIS_PID" "$JARVIS_FIFO"
            echo "${GREEN}[JARVIS]${RESET} Stopped"
        else
            echo "${ORANGE}[JARVIS]${RESET} Not running"
            rm -f "$JARVIS_PID"
        fi
    else
        echo "${ORANGE}[JARVIS]${RESET} Not running"
    fi
}

status_daemon() {
    if [ -f "$JARVIS_PID" ]; then
        local pid=$(cat "$JARVIS_PID")
        if kill -0 "$pid" 2>/dev/null; then
            echo "${GREEN}●${RESET} JARVIS is running (PID: $pid)"
        else
            echo "${RED}●${RESET} JARVIS is not running (stale PID file)"
        fi
    else
        echo "${RED}●${RESET} JARVIS is not running"
    fi
}

send_command() {
    if [ -p "$JARVIS_FIFO" ]; then
        echo "$1" > "$JARVIS_FIFO"
        echo "${GREEN}[JARVIS]${RESET} Command sent: $1"
    else
        echo "${RED}[JARVIS]${RESET} Not running. Start with: $0 start"
    fi
}

case "$1" in
    start)
        start_daemon
        ;;
    stop)
        stop_daemon
        ;;
    restart)
        stop_daemon
        sleep 1
        start_daemon
        ;;
    status)
        status_daemon
        ;;
    send)
        shift
        send_command "$*"
        ;;
    log)
        if [ -f "$JARVIS_LOG" ]; then
            tail -f "$JARVIS_LOG"
        else
            echo "No log file yet"
        fi
        ;;
    *)
        echo "JARVIS Daemon"
        echo ""
        echo "Usage: $0 {start|stop|restart|status|send|log}"
        echo ""
        echo "  start   - Start JARVIS in background"
        echo "  stop    - Stop JARVIS"
        echo "  restart - Restart JARVIS"
        echo "  status  - Check if running"
        echo "  send    - Send command to JARVIS"
        echo "  log     - View JARVIS log"
        ;;
esac
