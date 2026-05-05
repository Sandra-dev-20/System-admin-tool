#!/bin/bash
echo "FILE MANAGEMENT"

LOGFILE=~/script_activity.log
LOG() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOGFILE"
}

file_management() {
    while true; do
        echo ""
        echo "=== FILE MANAGEMENT ==="
        echo "1. Count files"
        echo "2. Show readable files"
        echo "3. Show writable files"
        echo "4. Show executable files"
        echo "5. Show top 5 lines of a file"
        echo "6. Show last 10 lines of a file"
        echo "7. Back"
        read -r -p "Choose an option: " FILE_CHOICE

        case $FILE_CHOICE in
            1)
                echo "Total files:"
                find . -maxdepth 1 -type f | wc -l 
		LOG "Counted files in current directory" ;;
            2)
                echo "Readable files:"
                find . -readable -type f ;;
            3)
                echo "Writable files:"
                find . -writable -type f ;;
            4)
                echo "Executable files:"
                find . -executable -type f ;;
            5)
                read -r -p "Enter filename: " FILE
		if [[ ! -f "$FILE" ]]; then
			echo "Error: File '$FILE' not found."
			continue
		fi
                head -5 "$FILE" ;;
            6)
                read -r -p "Enter filename: " FILE
		  if [[ ! -f "$FILE" ]]; then
                        echo "Error: File '$FILE' not found."
                        continue
                fi

                tail -10 "$FILE" ;;
            7)
                return ;;
            *)
                echo "Invalid option. Try again." ;;
        esac
    done
}


echo "SERVICE MANAGEMENT"
service_management() {
    while true; do
        echo ""
        echo "=== SERVICE MANAGEMENT ==="
        echo "1. Check specific service"
        echo "2. List running services"
        echo "3. List failed services"
        echo "4. Start a service"
        echo "5. Stop a service"
        echo "6. Restart a service"
        echo "7. Back"
        read -r -p "Choose an option: " SERVICE_CHOICE

        case $SERVICE_CHOICE in
            1)
                read -r -p "Enter service name: " SERVICE
		  if [[ -z "$SERVICE" ]]; then
                        echo "Error: Service name cannot be empty."
                        continue
                fi

                systemctl status "$SERVICE" ;;
            2)
                systemctl list-units --type=service --state=running ;;
            3)
                systemctl list-units --type=service --state=failed ;;
            4)
                read -r -p "Enter service name: " SERVICE
		read -r -p "Enter service name: " SERVICE
                  if [[ -z "$SERVICE" ]]; then
                        echo "Error: Service name cannot be empty."
                        continue
                fi
		sudo systemctl start "$SERVICE" 
		LOG "Started service: $SERVICE"  ;;
            5)
                read -r -p "Enter service name: " SERVICE
		read -r -p "Enter service name: " SERVICE
                  if [[ -z "$SERVICE" ]]; then
                        echo "Error: Service name cannot be empty."
                        continue
                fi
                sudo systemctl stop "$SERVICE" 
		 LOG "Started service: $SERVICE" ;;
            6)
                read -r -p "Enter service name: " SERVICE
		read -r -p "Enter service name: " SERVICE
                  if [[ -z "$SERVICE" ]]; then
                        echo "Error: Service name cannot be empty."
                        continue
                fi
                sudo systemctl restart "$SERVICE" 
		 LOG "Started service: $SERVICE" ;;
            7)
                return ;;
            *)
                echo "Invalid option. Try again." ;;
        esac
    done
}


echo "SYSTEM MONITORING"

system_monitoring() {
    while true; do
        echo ""
        echo "=== SYSTEM MONITORING ==="
        echo "1. Disk usage"
        echo "2. RAM usage"
        echo "3. CPU usage"
        echo "4. Network traffic"
        echo "5. Who is logged in"
        echo "6. Open ports"
        echo "7. Back"
        read -r -p "Choose an option: " SYSTEM_CHOICE

        case $SYSTEM_CHOICE in
            1)
                echo "Disk Usage:"
                df -h ;;
            2)
                echo "Free Memory:"
                free -m ;;
            3)
                echo "CPU Usage:"
                top -bn1 | grep "Cpu(s)" ;;
            4)
                echo "Network Traffic:"
                ifstat 1 1 2>/dev/null || echo "Install ifstat: sudo apt install ifstat" ;;
            5)
                echo "Logged-in Users:"
                who ;;
            6)
                echo "Open Ports:"
                sudo ss -tuln ;;
            7)
                return ;;
            *)
                echo "Invalid option. Try again." ;;
        esac
    done
}


echo "LOG ANALYSIS"

log_analysis() {
    while true; do
        echo ""
        echo "=== LOG ANALYSIS ==="
        echo "1. Log file sizes"
        echo "2. Count errors in a log"
        echo "3. Last modified log files"
        echo "4. Largest log files"
        echo "5. Back"
        read -r -p "Choose an option: " LOG_CHOICE

        case $LOG_CHOICE in
            1)
                echo "Log file sizes:"
                du -sh /var/log/* 2>/dev/null ;;
            2)
                read -r -p "Enter log file path: " LOGFILE
                echo "Error count:"
                grep -ic "error" "$LOGFILE" ;;
            3)
                echo "Recently modified log files:"
                find /var/log -type f -printf "%T@ %p\n" 2>/dev/null \
                    | sort -rn | head -10 | awk '{print $2}' ;;
            4)
                echo "Largest log files:"
                find /var/log -type f -exec du -sh {} + 2>/dev/null \
                    | sort -rh | head -5 ;;
            5)
                return ;;
            *)
                echo "Invalid option. Try again." ;;
        esac
    done
}


echo "MAIN MENU"
main_menu() {
    while true; do
        echo ""
        echo "==============================="
        echo "   SYSTEM ADMINISTRATION TOOL  "
        echo "==============================="
        echo "1. File Management"
        echo "2. Service Management"
        echo "3. System Monitoring"
        echo "4. Log Analysis"
        echo "5. Exit"
        read -r -p "Choose an option: " MAIN_CHOICE

        case $MAIN_CHOICE in
            1) file_management ;;
            2) service_management ;;
            3) system_monitoring ;;
            4) log_analysis ;;
            5)
                echo "Goodbye."
                exit 0 ;;
            *)
                echo "Invalid option. Try again." ;;
        esac
    done
}

# Entry point
main_menu
