#!/bin/sh
#
#      _____ _____ _ _____ _____         _____ _____ _____ _____ 
#  ___|     | __  |_|  _  |_   _|___ ___|_   _|   __|  _  |     |
# |_ -|   --|    -| |   __| | | |- _|___| | | |   __|     | | | |
# |___|_____|__|__|_|__|    |_| |___|     |_| |_____|__|__|_|_|_|
# |s C R i P T z - T E A M . i N F O|----------------------------
#
# |Tool: ServerSec - Server Security
# |Usage: sh serversecuriy.sh {start|stop}
# |Version: v1.0
#

if [ $# -eq 0 ]; then
echo "Usage:"
echo "sh serversecuriy.sh {start|stop}"
exit
fi

if [ $1 == "start" ]; then
# Clear rules
iptables -t filter -F
iptables -t filter -X
echo - Clear rules : [OK]

# SSH In
iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
echo - SSH : [OK]

# Don't break established connections
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
echo - Established connections : [OK]

# Block all connections by default
iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT DROP
echo - Block all connections : [OK]

# SYN-Flood Protection
iptables -N syn-flood
iptables -A syn-flood -m limit --limit 10/second --limit-burst 50 -j RETURN
iptables -A syn-flood -j LOG --log-prefix "SYN FLOOD: "
iptables -A syn-flood -j DROP
echo - SYN-Flood Protection : [OK]

# Loopback
iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT
echo - Loopback : [OK]

# ICMP (Ping)
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT
echo - PING : [OK]

# DNS In/Out
iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT
echo - DNS : [OK]

# NTP Out
iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT
echo - NTP : [OK]

# WHOIS Out
iptables -t filter -A OUTPUT -p tcp --dport 43 -j ACCEPT
echo - WHOIS : [OK]

# FTP Out
iptables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 30000:50000 -j ACCEPT
# FTP In
iptables -t filter -A INPUT -p tcp --dport 20:21 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 30000:50000 -j ACCEPT
iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
echo - FTP : [OK]

# HTTP + HTTPS Out
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT
# HTTP + HTTPS In
iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
echo - HTTP : [OK]
echo - HTTPS : [OK]

# Mail SMTP:25
iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT
echo - SMTP : [OK]

# Mail POP3:110
iptables -t filter -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 110 -j ACCEPT
echo - POP : [OK]

# Mail IMAP:143
iptables -t filter -A INPUT -p tcp --dport 143 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT
echo - IMAP : [OK]

echo - Firewall [OK]
exit
fi

if [ $1 == "stop" ]; then
echo "Stopping Firewall... "
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t filter -F
echo "Firewall Stopped!"
fi
