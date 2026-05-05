# System Administration Tool

A  Bash script menue for Linux system administration tasks including 
file management, service management, system monitoring, and log analysis.

---

## Features

- **File Management** — count, list, and inspect files by permission type
- **Service Management** — check, start, stop, and restart systemd services
- **System Monitoring** — view disk, RAM, CPU usage, open ports, and logged-in users
- **Log Analysis** — inspect log sizes, count errors, and find largest/recent logs
- **Activity Logging** — all actions are timestamped and saved to `~/script_activity.log`

---

## Requirements

- Linux (Ubuntu/Debian recommended)
- Bash 4.0+
- systemd (for service management)
- sudo privileges (for service start/stop/restart and port checking)

---

## Usage

### 1. Clone the repository
git clone https://github.com/Sandra-dev-20/system-admin-tool.git
cd system-admin-tool

### 2. Make the script executable
chmod +x system_monitor.sh

### 3. Run the script
./system_monitor.sh

---

## Project Structure

system-admin-tool/
├── system_monitor.sh   # Main script
└── README.md           # Documentation

---

## Activity Log

Every action taken through the tool is logged automatically:
cat ~/script_activity.log

Sample output:
[2024-11-01 10:23:45] Counted files in current directory
[2024-11-01 10:24:12] Started service: nginx
[2024-11-01 10:25:01] Checked disk usage

---

## Author

Sandie — DevOps Engineering Student, TS Academy
GitHub: https://github.com/yourusername
