# JARVIS for iSH Terminal

```
     ██╗ █████╗ ██████╗ ██╗   ██╗██╗███████╗
     ██║██╔══██╗██╔══██╗██║   ██║██║██╔════╝
     ██║███████║██████╔╝██║   ██║██║███████╗
██   ██║██╔══██║██╔══██╗╚██╗ ██╔╝██║╚════██║
╚█████╔╝██║  ██║██║  ██║ ╚████╔╝ ██║███████║
 ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚══════╝
```

## Installation (iSH)

```sh
# Clone or copy jarvis folder to iSH
cd ~
git clone <repo> trinity-

# Make executable
chmod +x trinity-/jarvis/*.sh

# Run JARVIS
./trinity-/jarvis/launch.sh
```

## Usage

### Launch with Matrix Effect
```sh
./launch.sh
```

### Launch without Matrix
```sh
./launch.sh --no-matrix
# or
./launch.sh -n
```

### Run as Background Daemon
```sh
./launch.sh --daemon
# or
./jarvis-daemon.sh start
```

### Daemon Commands
```sh
./jarvis-daemon.sh start    # Start background
./jarvis-daemon.sh stop     # Stop
./jarvis-daemon.sh status   # Check status
./jarvis-daemon.sh log      # View log
```

## JARVIS Commands

| Command | Description |
|---------|-------------|
| `help` | Show all commands |
| `status` | Show JARVIS status |
| `time` | Current time |
| `date` | Current date |
| `sysinfo` | System information |
| `disk` | Disk usage |
| `mem` | Memory usage |
| `net` | Network info |
| `ps` | Running processes |
| `ls [path]` | List directory |
| `cat [file]` | Read file |
| `run [cmd]` | Execute command |
| `search [term]` | Search files |
| `api [key]` | Set OpenAI API key |
| `mode [m]` | Set mode (free/openai) |
| `clear` | Clear screen |
| `exit` | Exit JARVIS |

## API Mode

To use OpenAI for real AI responses:

```
> api sk-your-openai-key-here
> mode openai
> Hello JARVIS, what's the weather like?
```

## Files

- `launch.sh` - Main launcher with matrix effect
- `jarvis.sh` - Core JARVIS assistant
- `jarvis-daemon.sh` - Background daemon
- `matrix.sh` - Matrix rain effect

## Requirements

- iSH / Alpine Linux / any POSIX shell
- `curl` (optional, for API mode)

Install curl:
```sh
apk add curl
```

---
TRINITY_ // JARVIS v0.1.0
