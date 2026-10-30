
#!/bin/bash

echo "===== SERVER PERFORMANCE STATS ====="

OS=$(uname)

# 1. CPU Usage
echo ""
echo "1. CPU Usage"

if [ "$OS" = "Darwin" ]; then
    top -l 2 -n 0 | grep "CPU usage" | tail -1
else
    top -bn1 | grep "Cpu(s)"
fi

# 2. Memory Usage
echo ""
echo "2. Memory Usage"

if [ "$OS" = "Darwin" ]; then
    vm_stat
else
    free -h
fi

# 3. Disk Usage
echo ""
echo "3. Disk Usage"
df -h

# 4. Top 5 Processes by CPU
echo ""
echo "4. Top 5 Processes by CPU"

printf "%-8s %-25s %s\n" "PID" "COMMAND" "CPU"

ps -A -o pid=,comm=,%cpu= | sort -k3,3nr | head -5

# 5. Top 5 Processes by Memory
echo ""
echo "5. Top 5 Processes by Memory"

printf "%-8s %-25s %s\n" "PID" "COMMAND" "MEMORY"

ps -A -o pid=,comm=,%mem= | sort -k3,3nr | head -5

# 6. OS Information
echo ""
echo "6. OS Information"

if [ "$OS" = "Darwin" ]; then
    sw_vers
else
    cat /etc/os-release
fi

# 7. System Uptime
echo ""
echo "7. System Uptime"
uptime

echo ""
echo "===== REPORT COMPLETED ====="
