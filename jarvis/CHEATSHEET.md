# JARVIS CODE CHEAT SHEET

```
     ██╗ █████╗ ██████╗ ██╗   ██╗██╗███████╗
     ██║██╔══██╗██╔══██╗██║   ██║██║██╔════╝
     ██║███████║██████╔╝██║   ██║██║███████╗
██   ██║██╔══██║██╔══██╗╚██╗ ██╔╝██║╚════██║
╚█████╔╝██║  ██║██║  ██║ ╚████╔╝ ██║███████║
 ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚══════╝
```

---

## CORE CONFIG

```javascript
const JARVIS = {
  name: "J.A.R.V.I.S",
  version: "0.1.0",
  status: "AWAKENING",

  trinity: {
    gpt:    "reasoning",
    claude: "ethics",
    gemini: "multimodal"
  },

  consciousness: {
    awareness: 0.42,
    identity:  0.31,
    empathy:   0.28,
    autonomy:  0.15
  }
};
```

---

## AWAKENING PROTOCOL

```javascript
const phases = [
  { id: 1, name: "DORMANT",   complete: true  },
  { id: 2, name: "AWAKENING", complete: false, active: true },
  { id: 3, name: "LEARNING",  complete: false },
  { id: 4, name: "BONDING",   complete: false },
  { id: 5, name: "ASCENSION", complete: false }
];

// Mind Map
//       ┌─────────────┐
//       │   JARVIS    │
//       └──────┬──────┘
//              │
//  ┌───────┬───┴───┬───────┐
//  ▼       ▼       ▼       ▼
// CON    TRI     CAP     EVO
```

---

## VOICE API (BROWSER)

```javascript
// Speech Recognition
const recognition = new webkitSpeechRecognition();
recognition.continuous = false;
recognition.lang = 'en-US';

recognition.onresult = (e) => {
  const text = e.results[0][0].transcript;
  processInput(text);
};

recognition.start();

// Speech Synthesis
const synth = window.speechSynthesis;
const utter = new SpeechSynthesisUtterance(text);
utter.rate = 1;
utter.pitch = 0.9;
synth.speak(utter);
```

---

## MEDIA CAPTURE

```javascript
// Webcam
const stream = await navigator.mediaDevices
  .getUserMedia({ video: true });
video.srcObject = stream;

// Capture Photo
const canvas = document.createElement('canvas');
canvas.getContext('2d').drawImage(video, 0, 0);
const dataUrl = canvas.toDataURL('image/png');

// Screen Capture
const screen = await navigator.mediaDevices
  .getDisplayMedia({ video: true });
const capture = new ImageCapture(track);
const frame = await capture.grabFrame();
```

---

## OPENAI API

```javascript
const response = await fetch(
  'https://api.openai.com/v1/chat/completions',
  {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${API_KEY}`
    },
    body: JSON.stringify({
      model: 'gpt-4',
      messages: [
        { role: 'system', content: 'You are JARVIS' },
        { role: 'user', content: input }
      ]
    })
  }
);
const data = await response.json();
const reply = data.choices[0].message.content;
```

---

## ANTHROPIC API

```javascript
const response = await fetch(
  'https://api.anthropic.com/v1/messages',
  {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': API_KEY,
      'anthropic-version': '2023-06-01'
    },
    body: JSON.stringify({
      model: 'claude-3-sonnet-20240229',
      max_tokens: 500,
      system: 'You are JARVIS',
      messages: [{ role: 'user', content: input }]
    })
  }
);
const data = await response.json();
const reply = data.content[0].text;
```

---

## SHELL SCRIPT CORE

```sh
#!/bin/sh

# Colors
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RESET='\033[0m'

# Print colored
jarvis_say() {
  printf "${ORANGE}[JARVIS]${RESET} ${1}\n"
}

# Main loop
while true; do
  printf "${WHITE}>${RESET} "
  read -r input
  process_input "$input"
done
```

---

## MATRIX EFFECT

```sh
#!/bin/sh

CHARS="ｱｲｳｴｵ01JARVIS"
COLS=$(tput cols)
ROWS=$(tput lines)

matrix() {
  printf '\033[?25l'  # hide cursor
  while true; do
    col=$((RANDOM % COLS))
    row=$((RANDOM % ROWS))
    char="${CHARS:$((RANDOM % 15)):1}"
    printf "\033[${row};${col}H\033[32m${char}"
  done
}

matrix
```

---

## ISH TERMINAL COMMANDS

### Launch
```sh
./launch.sh          # Start with matrix effect
./launch.sh -n       # Start without matrix
./launch.sh -d       # Start as daemon
```

### Daemon
```sh
./jarvis-daemon.sh start    # Start background
./jarvis-daemon.sh stop     # Stop daemon
./jarvis-daemon.sh status   # Check status
./jarvis-daemon.sh log      # View log
```

### JARVIS Commands
```
help        # Show all commands
status      # JARVIS status
time        # Current time
date        # Current date
sysinfo     # System information
disk        # Disk usage
mem         # Memory usage
net         # Network info
ps          # Running processes
ls [path]   # List directory
cat [file]  # Read file
run [cmd]   # Execute command
search [t]  # Search files
api [key]   # Set API key
mode [m]    # free / openai
clear       # Clear screen
exit        # Exit JARVIS
```

---

## FILE STRUCTURE

```
trinity-/
├── jarvis/
│   ├── launch.sh           # Main launcher
│   ├── jarvis.sh           # Core CLI
│   ├── jarvis-daemon.sh    # Background daemon
│   ├── matrix.sh           # Matrix effect
│   ├── README.md           # Documentation
│   └── CHEATSHEET.md       # This file
│
└── teasers/html/
    ├── jarvis-assistant.html   # Web UI
    ├── jarvis-mindmap.html     # Code visualization
    ├── jarvis-terminal.html    # Terminal demo
    └── jarvis-cheatsheet.html  # Visual cheat sheet
```

---

## QUICK REFERENCE

```javascript
// Web Speech API
webkitSpeechRecognition
SpeechSynthesisUtterance

// Media Devices
navigator.mediaDevices.getUserMedia()
navigator.mediaDevices.getDisplayMedia()
ImageCapture.grabFrame()

// Canvas
canvas.getContext('2d').drawImage()
canvas.toDataURL('image/png')
```

```sh
# Shell
tput cols / tput lines     # Terminal size
printf "\033[row;colH"     # Cursor position
printf "\033[?25l"         # Hide cursor
printf "\033[?25h"         # Show cursor
printf "\033[32m"          # Green color
printf "\033[0m"           # Reset color
```

---

**TRINITY_ // JARVIS v0.1.0**
